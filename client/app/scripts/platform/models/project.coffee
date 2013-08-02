angular.module('platform').factory 'Project', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
      add_volunteer: (project_id, user_id) ->
        Restangular.one('projects', project_id).customPOST 'add_volunteer', {user_id}
      add_supporter: (project_id, user_id) ->
        Restangular.one('projects', project_id).customPOST 'add_supporter', {user_id}
    return new Model(Restangular, $rootScope, $filter, 'project', 'projects')
]