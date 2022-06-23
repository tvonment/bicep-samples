targetScope = 'subscription'

@description('The Azure region into which the resources should be deployed.')
param location string = deployment().location

@description('Github Personal Access Token')
@secure()
param pat string

@description('The Prefix for the Resources')
param prefix string = 'samples'

@description('Name of the Resource Group')
param rGroupName string = 'rg-${prefix}-staticwebapp-azfunction'

resource rGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rGroupName
  location: location
}

module azfunction 'modules/azfunction.bicep' = {
  scope: resourceGroup(rGroup.name)
  name: '${deployment().name}-azfunction'
  params: {
    location: location
    prefix: prefix
  }
}

module staticwebapp 'modules/staticwebapp.bicep' = {
  scope: resourceGroup(rGroup.name)
  name: '${deployment().name}-staticwebapp'
  params: {
    prefix: prefix
    location: location
    pat: pat
  }
}
