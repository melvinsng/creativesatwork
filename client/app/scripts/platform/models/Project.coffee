angular.module('platform').factory 'Project', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
      add_bidder: (project_id, user_id) ->
        Restangular.one('projects', project_id).customPOST 'add_bidder', {user_id}
      add_offer: (project_id, user_id) ->
        Restangular.one('projects', project_id).customPOST 'add_offer', {user_id}
    return new Model(Restangular, $rootScope, $filter, 'project', 'projects')
]