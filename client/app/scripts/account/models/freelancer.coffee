angular.module('account').factory 'Freelancer', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Freelancer extends BaseModel

    return new Freelancer(Restangular, $rootScope, $filter, 'freelancer', 'freelancers')
]