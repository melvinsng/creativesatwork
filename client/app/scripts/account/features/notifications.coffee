angular.module('account').run [
  '$rootScope'
  ($rootScope) ->

    $rootScope.$on 'register:success', ->
      $rootScope.redirect_to 'user.profile', success: 'You are registered and logged in'

    $rootScope.$on 'login:success', ->
      $rootScope.redirect_to 'user.profile', success: 'You are logged in'

    $rootScope.$on 'logged_out', ->
      $rootScope.redirect_to 'home', success: 'You are logged out'
]
