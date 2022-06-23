@description('Prefix for resources')
param prefix string

@description('Github Personal Access Token')
@secure()
param pat string

@description('The name of the Static Web App')
param webAppName string = '${prefix}-staticwebapp-${uniqueString(resourceGroup().id)}'

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

resource staticwebapp 'Microsoft.Web/staticSites@2021-03-01' = {
  name: webAppName
  location: location
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {
    repositoryUrl: 'https://github.com/tvonment/bicep-samples/'
    branch: 'staticwebapp-azfunction-cosmos'
    repositoryToken: pat
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
    provider: 'GitHub'
    enterpriseGradeCdnStatus: 'Disabled'
    buildProperties: {
      appLocation: '/'
      apiLocation: ''
      appArtifactLocation: 'src'
    }
  }
}
