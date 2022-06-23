param sites_heroes_tvonment_name string = 'heroes-tvonment'
param staticSites_heroes_front_name string = 'heroes-front'
param serverfarms_ASP_HEROES_a44c_name string = 'ASP-HEROES-a44c'
param components_heroes_tvonment_name string = 'heroes-tvonment'
param storageAccounts_heroestvonment_name string = 'heroestvonment'
param databaseAccounts_heroes_core_name string = 'heroes-core'
param actionGroups_Application_Insights_Smart_Detection_name string = 'Application Insights Smart Detection'
param smartdetectoralertrules_failure_anomalies_heroes_tvonment_name string = 'failure anomalies - heroes-tvonment'
param workspaces_DefaultWorkspace_abe489da_01c9_4068_b7d5_1cd8156d601d_CHN_externalid string = '/subscriptions/abe489da-01c9-4068-b7d5-1cd8156d601d/resourceGroups/DefaultResourceGroup-CHN/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-abe489da-01c9-4068-b7d5-1cd8156d601d-CHN'

resource databaseAccounts_heroes_core_name_resource 'Microsoft.DocumentDB/databaseAccounts@2022-02-15-preview' = {
  name: databaseAccounts_heroes_core_name
  location: 'Switzerland North'
  tags: {
    defaultExperience: 'Core (SQL)'
    'hidden-cosmos-mmspecial': ''
  }
  kind: 'GlobalDocumentDB'
  identity: {
    type: 'None'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    enableFreeTier: false
    enableAnalyticalStorage: false
    analyticalStorageConfiguration: {
      schemaType: 'WellDefined'
    }
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    networkAclBypass: 'None'
    disableLocalAuth: false
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    locations: [
      {
        locationName: 'Switzerland North'
        provisioningState: 'Succeeded'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    cors: []
    capabilities: [
      {
        name: 'EnableServerless'
      }
    ]
    ipRules: []
    backupPolicy: {
      type: 'Periodic'
      periodicModeProperties: {
        backupIntervalInMinutes: 1440
        backupRetentionIntervalInHours: 48
        backupStorageRedundancy: 'Local'
      }
    }
    networkAclBypassResourceIds: []
    diagnosticLogSettings: {
      enableFullTextQuery: 'None'
    }
    capacity: {
      totalThroughputLimit: 4000
    }
  }
}

resource actionGroups_Application_Insights_Smart_Detection_name_resource 'microsoft.insights/actionGroups@2022-06-01' = {
  name: actionGroups_Application_Insights_Smart_Detection_name
  location: 'Global'
  properties: {
    groupShortName: 'SmartDetect'
    enabled: true
    emailReceivers: []
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: [
      {
        name: 'Monitoring Contributor'
        roleId: '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
        useCommonAlertSchema: true
      }
      {
        name: 'Monitoring Reader'
        roleId: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
        useCommonAlertSchema: true
      }
    ]
  }
}

resource components_heroes_tvonment_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_heroes_tvonment_name
  location: 'switzerlandnorth'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaWebAppExtensionCreate'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_abe489da_01c9_4068_b7d5_1cd8156d601d_CHN_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource storageAccounts_heroestvonment_name_resource 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccounts_heroestvonment_name
  location: 'switzerlandnorth'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'Storage'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

resource serverfarms_ASP_HEROES_a44c_name_resource 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: serverfarms_ASP_HEROES_a44c_name
  location: 'Switzerland North'
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
  kind: 'functionapp'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource staticSites_heroes_front_name_resource 'Microsoft.Web/staticSites@2021-03-01' = {
  name: staticSites_heroes_front_name
  location: 'West Europe'
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {
    repositoryUrl: 'https://github.com/tvonment/react-heroes'
    branch: 'main'
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
    provider: 'GitHub'
    enterpriseGradeCdnStatus: 'Disabled'
  }
}

resource databaseAccounts_heroes_core_name_heroes_db 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2022-02-15-preview' = {
  parent: databaseAccounts_heroes_core_name_resource
  name: 'heroes-db'
  properties: {
    resource: {
      id: 'heroes-db'
    }
  }
}

resource databaseAccounts_heroes_core_name_00000000_0000_0000_0000_000000000001 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2022-02-15-preview' = {
  parent: databaseAccounts_heroes_core_name_resource
  name: '00000000-0000-0000-0000-000000000001'
  properties: {
    roleName: 'Cosmos DB Built-in Data Reader'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_heroes_core_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read'
        ]
        notDataActions: []
      }
    ]
  }
}

resource databaseAccounts_heroes_core_name_00000000_0000_0000_0000_000000000002 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2022-02-15-preview' = {
  parent: databaseAccounts_heroes_core_name_resource
  name: '00000000-0000-0000-0000-000000000002'
  properties: {
    roleName: 'Cosmos DB Built-in Data Contributor'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_heroes_core_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*'
        ]
        notDataActions: []
      }
    ]
  }
}

resource components_heroes_tvonment_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'degradationindependencyduration'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'degradationinserverresponsetime'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'digestMailConfiguration'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'extension_canaryextension'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'extension_memoryleakextension'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'extension_securityextensionspackage'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'extension_traceseveritydetector'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'longdependencyduration'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'slowpageloadtime'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_heroes_tvonment_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_heroes_tvonment_name_resource
  name: 'slowserverresponsetime'
  location: 'switzerlandnorth'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource storageAccounts_heroestvonment_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: storageAccounts_heroestvonment_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_heroestvonment_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-09-01' = {
  parent: storageAccounts_heroestvonment_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_heroestvonment_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-09-01' = {
  parent: storageAccounts_heroestvonment_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_heroestvonment_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-09-01' = {
  parent: storageAccounts_heroestvonment_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_heroes_tvonment_name_resource 'Microsoft.Web/sites@2021-03-01' = {
  name: sites_heroes_tvonment_name
  location: 'Switzerland North'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/abe489da-01c9-4068-b7d5-1cd8156d601d/resourceGroups/HEROES/providers/microsoft.insights/components/heroes-tvonment'
    'hidden-link: /app-insights-instrumentation-key': 'd0e29729-9804-428c-946f-c8ddaeacd5a5'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=d0e29729-9804-428c-946f-c8ddaeacd5a5;IngestionEndpoint=https://switzerlandnorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://switzerlandnorth.livediagnostics.monitor.azure.com/'
  }
  kind: 'functionapp,linux'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_heroes_tvonment_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_heroes_tvonment_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_HEROES_a44c_name_resource.id
    reserved: true
    isXenon: false
    hyperV: false
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: 'NODE|16'
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    customDomainVerificationId: 'FCBD62108FD020DBA63C0225D31A0F3BE7D863925E671D8F2F73E795983044C8'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_heroes_tvonment_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2021-03-01' = {
  parent: sites_heroes_tvonment_name_resource
  name: 'ftp'
  location: 'Switzerland North'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/abe489da-01c9-4068-b7d5-1cd8156d601d/resourceGroups/HEROES/providers/microsoft.insights/components/heroes-tvonment'
    'hidden-link: /app-insights-instrumentation-key': 'd0e29729-9804-428c-946f-c8ddaeacd5a5'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=d0e29729-9804-428c-946f-c8ddaeacd5a5;IngestionEndpoint=https://switzerlandnorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://switzerlandnorth.livediagnostics.monitor.azure.com/'
  }
  properties: {
    allow: true
  }
}

resource sites_heroes_tvonment_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2021-03-01' = {
  parent: sites_heroes_tvonment_name_resource
  name: 'scm'
  location: 'Switzerland North'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/abe489da-01c9-4068-b7d5-1cd8156d601d/resourceGroups/HEROES/providers/microsoft.insights/components/heroes-tvonment'
    'hidden-link: /app-insights-instrumentation-key': 'd0e29729-9804-428c-946f-c8ddaeacd5a5'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=d0e29729-9804-428c-946f-c8ddaeacd5a5;IngestionEndpoint=https://switzerlandnorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://switzerlandnorth.livediagnostics.monitor.azure.com/'
  }
  properties: {
    allow: true
  }
}

resource sites_heroes_tvonment_name_web 'Microsoft.Web/sites/config@2021-03-01' = {
  parent: sites_heroes_tvonment_name_resource
  name: 'web'
  location: 'Switzerland North'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/abe489da-01c9-4068-b7d5-1cd8156d601d/resourceGroups/HEROES/providers/microsoft.insights/components/heroes-tvonment'
    'hidden-link: /app-insights-instrumentation-key': 'd0e29729-9804-428c-946f-c8ddaeacd5a5'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=d0e29729-9804-428c-946f-c8ddaeacd5a5;IngestionEndpoint=https://switzerlandnorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://switzerlandnorth.livediagnostics.monitor.azure.com/'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'NODE|16'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2019'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$heroes-tvonment'
    scmType: 'GitHubAction'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    cors: {
      allowedOrigins: [
        'https://portal.azure.com'
        'https://salmon-dune-05a1c7403.1.azurestaticapps.net'
        'http://127.0.0.1:3000'
      ]
      supportCredentials: false
    }
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.0'
    ftpsState: 'AllAllowed'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 200
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {
    }
  }
}

resource sites_heroes_tvonment_name_DelHero 'Microsoft.Web/sites/functions@2021-03-01' = {
  parent: sites_heroes_tvonment_name_resource
  name: 'DelHero'
  location: 'Switzerland North'
  properties: {
    script_root_path_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/DelHero/'
    script_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/dist/DelHero/index.js'
    config_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/DelHero/function.json'
    test_data_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/tmp/FunctionsData/DelHero.dat'
    href: 'https://heroes-tvonment.azurewebsites.net/admin/functions/DelHero'
    config: {
    }
    invoke_url_template: 'https://heroes-tvonment.azurewebsites.net/api/hero/{id}'
    language: 'node'
    isDisabled: false
  }
}

resource sites_heroes_tvonment_name_Hero 'Microsoft.Web/sites/functions@2021-03-01' = {
  parent: sites_heroes_tvonment_name_resource
  name: 'Hero'
  location: 'Switzerland North'
  properties: {
    script_root_path_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/Hero/'
    script_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/dist/Hero/index.js'
    config_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/Hero/function.json'
    test_data_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/tmp/FunctionsData/Hero.dat'
    href: 'https://heroes-tvonment.azurewebsites.net/admin/functions/Hero'
    config: {
    }
    invoke_url_template: 'https://heroes-tvonment.azurewebsites.net/api/hero/{id}'
    language: 'node'
    isDisabled: false
  }
}

resource sites_heroes_tvonment_name_Heroes 'Microsoft.Web/sites/functions@2021-03-01' = {
  parent: sites_heroes_tvonment_name_resource
  name: 'Heroes'
  location: 'Switzerland North'
  properties: {
    script_root_path_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/Heroes/'
    script_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/dist/Heroes/index.js'
    config_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/Heroes/function.json'
    test_data_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/tmp/FunctionsData/Heroes.dat'
    href: 'https://heroes-tvonment.azurewebsites.net/admin/functions/Heroes'
    config: {
    }
    invoke_url_template: 'https://heroes-tvonment.azurewebsites.net/api/heroes'
    language: 'node'
    isDisabled: false
  }
}

resource sites_heroes_tvonment_name_PostHero 'Microsoft.Web/sites/functions@2021-03-01' = {
  parent: sites_heroes_tvonment_name_resource
  name: 'PostHero'
  location: 'Switzerland North'
  properties: {
    script_root_path_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/PostHero/'
    script_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/dist/PostHero/index.js'
    config_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/home/site/wwwroot/PostHero/function.json'
    test_data_href: 'https://heroes-tvonment.azurewebsites.net/admin/vfs/tmp/FunctionsData/PostHero.dat'
    href: 'https://heroes-tvonment.azurewebsites.net/admin/functions/PostHero'
    config: {
    }
    invoke_url_template: 'https://heroes-tvonment.azurewebsites.net/api/hero/'
    language: 'node'
    isDisabled: false
  }
}

resource sites_heroes_tvonment_name_sites_heroes_tvonment_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2021-03-01' = {
  parent: sites_heroes_tvonment_name_resource
  name: '${sites_heroes_tvonment_name}.azurewebsites.net'
  location: 'Switzerland North'
  properties: {
    siteName: 'heroes-tvonment'
    hostNameType: 'Verified'
  }
}

resource smartdetectoralertrules_failure_anomalies_heroes_tvonment_name_resource 'microsoft.alertsmanagement/smartdetectoralertrules@2021-04-01' = {
  name: smartdetectoralertrules_failure_anomalies_heroes_tvonment_name
  location: 'global'
  properties: {
    description: 'Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls.'
    state: 'Enabled'
    severity: 'Sev3'
    frequency: 'PT1M'
    detector: {
      id: 'FailureAnomaliesDetector'
    }
    scope: [
      components_heroes_tvonment_name_resource.id
    ]
    actionGroups: {
      groupIds: [
        actionGroups_Application_Insights_Smart_Detection_name_resource.id
      ]
    }
  }
}

resource databaseAccounts_heroes_core_name_heroes_db_Heroes 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2022-02-15-preview' = {
  parent: databaseAccounts_heroes_core_name_heroes_db
  name: 'Heroes'
  properties: {
    resource: {
      id: 'Heroes'
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/"_etag"/?'
          }
        ]
      }
      partitionKey: {
        paths: [
          '/id'
        ]
        kind: 'Hash'
      }
      uniqueKeyPolicy: {
        uniqueKeys: []
      }
      conflictResolutionPolicy: {
        mode: 'LastWriterWins'
        conflictResolutionPath: '/_ts'
      }
    }
  }
  dependsOn: [

    databaseAccounts_heroes_core_name_resource
  ]
}

resource databaseAccounts_heroes_core_name_heroes_db_leases 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2022-02-15-preview' = {
  parent: databaseAccounts_heroes_core_name_heroes_db
  name: 'leases'
  properties: {
    resource: {
      id: 'leases'
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/"_etag"/?'
          }
        ]
      }
      partitionKey: {
        paths: [
          '/_partitionKey'
        ]
        kind: 'Hash'
        version: 2
      }
      conflictResolutionPolicy: {
        mode: 'LastWriterWins'
        conflictResolutionPath: '/_ts'
      }
    }
  }
  dependsOn: [

    databaseAccounts_heroes_core_name_resource
  ]
}

resource storageAccounts_heroestvonment_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: storageAccounts_heroestvonment_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_heroestvonment_name_resource
  ]
}

resource storageAccounts_heroestvonment_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: storageAccounts_heroestvonment_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_heroestvonment_name_resource
  ]
}

resource storageAccounts_heroestvonment_name_default_scm_releases 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: storageAccounts_heroestvonment_name_default
  name: 'scm-releases'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_heroestvonment_name_resource
  ]
}

resource storageAccounts_heroestvonment_name_default_heroes_tvonmenta826 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-09-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_heroestvonment_name_default
  name: 'heroes-tvonmenta826'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [

    storageAccounts_heroestvonment_name_resource
  ]
}