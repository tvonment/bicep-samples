@description('The Azure region into which the resources should be deployed.')
param location string

@description('Prefix for resources')
param prefix string

@description('The name of the App Service app.')
param name string = '${prefix}-vault-${uniqueString(resourceGroup().id)}'

resource vault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: name
  location: location
}
