param nameprefix string
param env string
param user_url string

var apimname = '${nameprefix}-apim-${env}'

resource apim 'Microsoft.ApiManagement/service@2021-12-01-preview' existing = {
  name: apimname
}



resource api_user 'Microsoft.ApiManagement/service/apis@2021-08-01' = {
  parent: apim
  name: 'user'
  properties: {
    displayName: 'User'
    apiRevision: '2'
    subscriptionRequired: true
    serviceUrl: user_url
    path: 'user'
    protocols: [
      'https'
    ]
    isCurrent: true
  }
}

resource api_user_get 'Microsoft.ApiManagement/service/apis/operations@2021-08-01' = {
  parent: api_user
  name: 'get'
  properties: {
    displayName: 'Get'
    method: 'GET'
    urlTemplate: '/'
    templateParameters: []
    request: {
      queryParameters: []
      headers: []
      representations: []
    }
    responses: []
  }
}

resource api_user_get_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-12-01-preview' = {
  parent: api_user_get
  name: 'policy'
  properties: {
    value: loadTextContent('./apim_policies/user_get_policy.xml')
    format: 'xml'
  }
}


