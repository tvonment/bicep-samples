@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The Prefix for the Resources')
param prefix string = 'vm'