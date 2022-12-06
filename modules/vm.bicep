param prefix string
param location string
param adminUsername string = 'cosouser'
param vmName string
param vnetName string
param subnetName string
param nsgName string
param vaultName string

var pwd = '${toUpper(uniqueString('${resourceGroup().id}-${vmName}'))}-${uniqueString(resourceGroup().id)}'

resource nsg 'Microsoft.Network/networkSecurityGroups@2022-07-01' existing = {
  name: nsgName
}

resource vnet 'Microsoft.Network/virtualNetworks@2022-07-01' existing = {
  name: vnetName
}

resource vault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: vaultName
}

resource pubip 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: '${prefix}-${vmName}-pubip'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
}

resource interface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: '${prefix}-${vmName}-interface'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: '${prefix}-${vmName}-ipconfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pubip.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetName)
          }
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    nicType: 'Standard'
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource password 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  name: 'pwd-${vmName}'
  parent: vault
  properties: {
    attributes: {
      enabled: true
    }
    contentType: 'string'
    value: pwd
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: '${prefix}-${vmName}'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      imageReference: {
        publisher: 'microsoftwindowsdesktop'
        offer: 'windows-11'
        sku: 'win11-21h2-pro'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${prefix}-${vmName}-osdisk-${uniqueString(resourceGroup().id)}'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }
    osProfile: {
      computerName: '${prefix}-${vmName}'
      adminUsername: adminUsername
      adminPassword: pwd
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: interface.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
    licenseType: 'Windows_Client'
  }
}

resource shutdown 'Microsoft.DevTestLab/schedules@2018-09-15' = {
  name: 'shutdown-computevm-${prefix}-${vmName}'
  location: location
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '2200'
    }
    timeZoneId: 'W. Europe Standard Time'
    notificationSettings: {
      status: 'Disabled'
    }
    targetResourceId: vm.id
  }
}
