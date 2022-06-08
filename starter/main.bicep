targetScope = 'subscription'

param location string = 'uksouth'
param nameprefix string // TODO: Add a name prefix here for a consistent naming convention
param env string = 'dev'
param apimemail string // You need to an email address for apim.  It can be a dummy

var apimrgname = '${nameprefix}-rg-${env}'
var apimname = '${nameprefix}-apim-${env}'

// Create apim rg
resource apimrg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: apimrgname
  location: location
}

/* 
Create an apim.bicep file, 
declare parameters that match below.
In the file create an apim instance.
If you get stuff there are examples here:
https://github.com/Azure/bicep/tree/main/docs/examples

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
*/
