@description('The name of the Cosmos DB')
param cosmosDBAccountName string = 'bicep-samples-${uniqueString(resourceGroup().id)}'

@description('Prefix for resources')
param prefix string

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

var cosmosDBDatabaseName = '${prefix}-db'
var cosmosDBContainerName = '${prefix}-container'
var cosmosDBContainerPartitionKey = '/someCoolPartitionKey'

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: cosmosDBAccountName
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
    capabilities: [
      {
        name: 'EnableServerless'
      }
    ]
  }
  resource cosmosDBDatabase 'sqlDatabases' = {
    name: cosmosDBDatabaseName
    properties: {
      resource: {
        id: cosmosDBDatabaseName
      }
    }
    resource container 'containers' = {
      name: cosmosDBContainerName
      properties: {
        resource: {
          id: cosmosDBContainerName
          partitionKey: {
            kind: 'Hash'
            paths: [
              cosmosDBContainerPartitionKey
            ]
          }
        }
        options: {}
      }
    }
  }
}
@description('The name of the CosmosDB Account.')
output cosmosDBAccountName string = cosmosDBAccount.name
