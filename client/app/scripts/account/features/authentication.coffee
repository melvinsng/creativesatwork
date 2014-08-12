angular.module('account').run [
  '$rootScope'
  'Auth'
  '$q'
  'RouteSession'
  ($rootScope, Auth, $q, RouteSession) ->

    $rootScope.logout = ->
      Auth.logout()
      $rootScope.$broadcast 'logged_out'
      $rootScope.redirect_to '', success: 'You are logged out'

    $rootScope.attemptLogin = (opts={})->
      deferred = $q.defer()
      if $rootScope.authenticated? and $rootScope.authenticated
        $rootScope.$broadcast 'user_ready'
        deferred.resolve($rootScope.current_user)
      else
        authenticated = Auth.user delegate: true
        authenticated.then ((user) ->
          $rootScope.current_user = user
          $rootScope.authenticated = true
          $rootScope.user_class = user.user_type
          $rootScope.user_type = user.user_type.toLowerCase()
          opts.successHandler?(user)
          $rootScope.$broadcast 'user_ready'
          deferred.resolve(user)
        ), ->
          $rootScope.current_user = null
          $rootScope.authenticated = false
          $rootScope.user_class = 'User'
          $rootScope.user_type = 'guest'
          $rootScope.$broadcast 'user_ready'
          opts.failedHandler?(user)
          deferred.reject('user is not logged in')
      deferred.promise

    angular.forEach ['logged_out', 'login:started'], (event) ->
      $rootScope.$on event, ->
        $rootScope.current_user = null
        $rootScope.authenticated = false
        $rootScope.user_class = 'User'
        $rootScope.user_type = 'guest'

    $rootScope.$on 'authenticate:success', (event, response) ->
      $rootScope.attemptLogin {
        successHandler: (user) ->
          console.log $rootScope.user_type
          success_msg = if response.register then 'Welcome to CreativesAtWork!' else 'You are logged in'
          if RouteSession.isEmpty()
            if $rootScope.user_type == 'admin'
              $rootScope.redirect_to "admin.users"
            else
              $rootScope.redirect_to "dashboard.#{user.user_type.toLowerCase()}.profile", success: success_msg
          else
            prev_path = RouteSession.path
            RouteSession.destroy()
            $rootScope.redirect_to prev_path, success: 'You are logged in!'
      }

    $rootScope.attemptLogin()

]