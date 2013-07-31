angular.module('account').run [
  '$rootScope'
  'Auth'
  '$q'
  ($rootScope, Auth, $q) ->

    $rootScope.logout = ->
      Auth.logout()

    angular.forEach ['logged_out', 'login:started'], (event) ->
      $rootScope.$on event, ->
        $rootScope.current_user = null
        $rootScope.authenticated = false
        $rootScope.user_class = 'User'
        $rootScope.user_type = 'guest'

    angular.forEach ['session:created'], (event) ->
      $rootScope.$on event, (ev, user) ->
        $rootScope.current_user = user
        $rootScope.authenticated = true
        $rootScope.user_class = user.user_type
        $rootScope.user_type = user.user_type.toLowerCase()

    $rootScope.attemptLogin = ->
      deferred = $q.defer()
      if $rootScope.authenticated? and $rootScope.authenticated
        deferred.resolve($rootScope.current_user)
      else
        authenticated = Auth.user delegate: true
        authenticated.then ((user) ->
          $rootScope.current_user = user
          $rootScope.authenticated = true
          $rootScope.user_class = user.user_type
          $rootScope.user_type = user.user_type.toLowerCase()
          deferred.resolve(user)
        ), ->
          $rootScope.current_user = null
          $rootScope.authenticated = false
          $rootScope.user_class = 'User'
          $rootScope.user_type = 'guest'
          deferred.reject('user is not logged in')
      deferred.promise

    $rootScope.attemptLogin()

]