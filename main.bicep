targetScope = 'subscription'

@description('The Azure region into which the resources should be deployed.')
param location string = deployment().location

@description('The Prefix for the Resources')
param prefix string = 'bicep-samples'

@description('Name of the Resource Group')
param rGroupName string = 'rg-${prefix}-webapp-cosmos-vault'

resource rGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rGroupName
  location: location
}

module cosmos 'modules/cosmos.bicep' = {
  scope: resourceGroup(rGroup.name)
  name: '${deployment().name}-cosmos'
  params: {
    location: location
    prefix: prefix
  }
}

module webapp 'modules/webapp.bicep' = {
  scope: resourceGroup(rGroup.name)
  name: '${deployment().name}-webapp'
  params: {
    location: location
    prefix: prefix
    cosmosDBAccountName: cosmos.outputs.cosmosDBAccountName
  }
}

module cdn 'modules/vault.bicep' = {
  scope: resourceGroup(rGroup.name)
  name: '${deployment().name}-vault'
  params: {
    prefix: prefix
    location: location
  }
}
