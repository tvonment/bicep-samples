@description('The Azure region into which the resources should be deployed.')
param location string

@description('Prefix for resources')
param prefix string

@description('The name of the App Service app.')
param appServiceAppName string = '${prefix}-webapp-${uniqueString(resourceGroup().id)}'

@description('The name of the App Service plan.')
param appServicePlanName string = '${prefix}-webapp-plan'

@description('The name of the App Service plan SKU.')
param appServicePlanSkuName string = 'F1'

@description('The name of the Cosmos DB')
param cosmosDBAccountName string

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' existing = {
  name: cosmosDBAccountName
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-01-15' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'COSMOS_DB_KEY'
          value: cosmosDBAccount.listConnectionStrings().connectionStrings[0].connectionString
        }
      ]
    }
  }
}

@description('The default host name of the App Service app.')
output appServiceAppHostName string = appServiceApp.properties.defaultHostName
