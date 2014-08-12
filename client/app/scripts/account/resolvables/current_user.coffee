resolvables['current_user'] = [
  'Auth'
  '$q'
  '$rootScope'
  '$location'
  'RouteSession'
  (Auth, $q, $rootScope, $location, RouteSession) ->
    authenticated = Auth.user delegate: true
    authenticated.then ((user) ->
      $rootScope.current_user = user
      $rootScope.authenticated = true
      $rootScope.user_class = user.user_type
      $rootScope.user_type = user.user_type.toLowerCase()
      user
    ), ->
      $rootScope.current_user = null
      $rootScope.authenticated = false
      $rootScope.user_class = 'User'
      $rootScope.user_type = 'guest'
      $rootScope.notify_error 'Please login first', false
      RouteSession.set $location.path()
      $location.path 'home'
      $q.reject('Access not allowed')
]