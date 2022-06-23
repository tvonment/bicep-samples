targetScope = 'subscription'

@description('The Azure region into which the resources should be deployed.')
param location string = deployment().location

@description('The Prefix for the Resources')
param prefix string = 'samples'

@description('Name of the Resource Group')
param rGroupName string = 'rg-${prefix}-azfunction-cosmos'

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
    isServerless: false
  }
}

module azfunction 'modules/azfunction.bicep' = {
  scope: resourceGroup(rGroup.name)
  name: '${deployment().name}-azfunction'
  params: {
    location: location
    prefix: prefix
    cosmosDBAccountName: cosmos.outputs.cosmosDBAccountName
  }
}
