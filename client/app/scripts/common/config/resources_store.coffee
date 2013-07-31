angular.module('common').config [
  'RestangularProvider'
  'ServiceEndpoint'
  (RestangularProvider, ServiceEndpoint) ->
    RestangularProvider.setBaseUrl ServiceEndpoint
    RestangularProvider.setListTypeIsArray true

    RestangularProvider.setFullRequestInterceptor (element, operation, route, url, headers, params) ->
      {
        element
        operation
        route
        url
        headers
        params
      }

    RestangularProvider.setResponseExtractor (response, operation) ->
      response

    #RestangularProvider.setRestangularFields id: "_id.$oid"

]
