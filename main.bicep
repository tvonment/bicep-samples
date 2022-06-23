targetScope = 'subscription'

@description('The Azure region into which the resources should be deployed.')
param location string = deployment().location

@description('The Prefix for the Resources')
param prefix string = 'samples'

param envs array = [
  {
    name: 'dev'
    sku: 'F1'
  }
  {
    name: 'test'
    sku: 'S1'
  }
  {
    name: 'prod'
    sku: 'S1'
  }
]

resource rGroups 'Microsoft.Resources/resourceGroups@2021-04-01' = [for env in envs: {
  name: 'rg-${env.name}-${prefix}'
  location: location
}]

module apps 'modules/app.bicep' = [for env in envs: {
  scope: resourceGroup('rg-${env.name}-${prefix}')
  name: '${env.name}-app-${uniqueString('rg-${env.name}-${prefix}')}'
  dependsOn: rGroups
  params: {
    appServiceAppName: '${env.name}-app-${uniqueString('rg-${env.name}-${prefix}')}'
    appServicePlanName: '${env.name}-app-plan'
    appServicePlanSkuName: env.sku
    location: location
  }
}]

module cdn 'modules/cdn.bicep' = [for (env, i) in envs: if (env.name == 'prod') {
  scope: resourceGroup('rg-${env.name}-${prefix}')
  name: '${env.name}-cdn-${uniqueString('rg-${env.name}-${prefix}')}'
  dependsOn: apps
  params: {
    originHostName: apps[i].outputs.appServiceAppHostName
  }
}]

output deployedApps array = [for (env, i) in envs: {
  appName: apps[i].name
  hostName: (env.name == 'prod') ? cdn[i].outputs.endpointHostName : apps[i].outputs.appServiceAppHostName
}]
