resolvables['current_user'] = [
  'Auth'
  '$q'
  '$rootScope'
  (Auth, $q, $rootScope) ->
    authenticated = Auth.user delegate: true
    authenticated.then ((user) ->
      $rootScope.current_user = user
      $rootScope.authenticated = true
      $rootScope.user_type = user.user_type.toLowerCase()
      user
    ), ->
      $rootScope.current_user = null
      $rootScope.authenticated = false
      $rootScope.user_type = 'guest'
      alert('access failed')
      $rootScope.error_notification 'You need to login to access this page', false
      $q.reject('Access not allowed')
]