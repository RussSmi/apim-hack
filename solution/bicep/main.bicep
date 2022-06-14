targetScope = 'subscription'

param location string = 'uksouth'
param nameprefix string = 'hastingsdemo'
param env string = 'dev'
param apimemail string

var apimrgname = '${nameprefix}-rg-${env}'
var apimname = '${nameprefix}-apim-${env}'

// Create apim rg
resource apimrg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: apimrgname
  location: location
}

module apim 'apim.bicep' = {
  name: apimname
  scope: apimrg
  params: {
    location: location
    nameprefix: nameprefix
    env: env
    apimname: apimname
    apimemail: apimemail
  }
}

