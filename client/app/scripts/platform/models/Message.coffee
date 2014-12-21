angular.module('platform').factory 'Message', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
    return new Model(Restangular, $rootScope, $filter, 'message', 'messages')
]