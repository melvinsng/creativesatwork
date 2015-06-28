angular.module('platform').factory 'Message', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
      get_threads: (user_id) ->
        Restangular.all('messages').customGET 'threads', {user_id}
    return new Model(Restangular, $rootScope, $filter, 'message', 'messages')
]