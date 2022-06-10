param location string = resourceGroup().location
param nameprefix string
param env string
param apimname string
param apimemail string

var logaworkspacename = '${nameprefix}loga${env}'


// Create the appInsights workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: logaworkspacename
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: '${apimname}-apiminsights'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

resource apim 'Microsoft.ApiManagement/service@2020-12-01' = {
  name: apimname
  location: location
  sku:{
    capacity: 0
    name: 'Consumption'
  }
  identity:{
    type: 'SystemAssigned'
  }
  properties:{
    virtualNetworkType: 'None'
    publisherEmail: apimemail
    publisherName: 'russ'
  }
}

resource namedValueAppInsightsKey 'Microsoft.ApiManagement/service/namedValues@2021-08-01' = {
  parent: apim
  name: 'instrumentationKey'
  properties: {
    tags: []
    secret: false
    displayName: 'instrumentationKey'
    value: appInsights.properties.InstrumentationKey
  }
}

resource apimLogger 'Microsoft.ApiManagement/service/loggers@2021-08-01' = {
  parent: apim
  name: '${nameprefix}apimlogger'
  properties:{
    resourceId: appInsights.id
    description: 'Application Insights for APIM'
    loggerType: 'applicationInsights'
    credentials:{
      instrumentationKey: namedValueAppInsightsKey.properties.value
    }
  }
}
