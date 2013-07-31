angular.module('account').factory 'Employer', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Employer extends BaseModel

    return new Employer(Restangular, $rootScope, $filter, 'employer', 'employers')
]