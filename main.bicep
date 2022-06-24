@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The Prefix for the Resources')
param prefix string = 'strg'

@description('The name for the Storage Account')
param name string = '${prefix}${uniqueString(resourceGroup().id)}'

resource strg 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
