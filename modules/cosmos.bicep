@description('Prefix for resources')
param prefix string

@description('Is a Serverless Deployment')
param isServerless bool = true

@description('The name of the Cosmos DB')
param cosmosDBAccountName string = '${prefix}-cosmos-${uniqueString(resourceGroup().id)}'

@description('The Throughput of the Cosmos Database')
@minValue(400)
@maxValue(10000)
param cosmosDBDatabaseThroughput int = 400

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

var cosmosDBDatabaseName = '${prefix}-db'
var cosmosDBContainerName = '${prefix}-container'
var cosmosDBContainerPartitionKey = '/id'

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: cosmosDBAccountName
  location: location
  properties: isServerless ? {
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
  } : {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
  }

  resource cosmosDBDatabase 'sqlDatabases' = {
    name: cosmosDBDatabaseName
    properties: {
      resource: {
        id: cosmosDBDatabaseName
      }
      options: isServerless ? {} : {
        throughput: cosmosDBDatabaseThroughput
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
