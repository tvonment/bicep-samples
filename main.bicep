@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location
@description('The name-prefix for the resources.')
param prefix string = 'tvm'
@description('Count of VM Clients')
param count int = 3

var subnetName = '${prefix}-vm-subnet'

resource vnet 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: '${prefix}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/24'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.1.0.0/26'
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.1.0.64/26'
        }
      }
    ]
  }
}

resource bastion_pubip 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: '${prefix}-bastion-pubip'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2022-07-01' = {
  name: '${prefix}-bastion'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    ipConfigurations: [
      {
        name: '${prefix}-bastion-ipconf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: bastion_pubip.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, 'AzureBastionSubnet')
          }
        }
      }
    ]
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2022-07-01' = {
  name: '${prefix}-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'RDP'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '3389'
          priority: 300
        }
      }
    ]
  }
}

resource vault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: '${prefix}-vault-${uniqueString(resourceGroup().id)}'
  location: location
  properties: {
    accessPolicies: []
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
  }
}

module vms 'modules/vm.bicep' = [for i in range(1, count): {
  name: 'vm-${i}'
  params: {
    location: location
    nsgName: nsg.name
    prefix: prefix
    subnetName: subnetName
    vmName: 'vm-${i}'
    vnetName: vnet.name
    vaultName: vault.name
  }
}]
