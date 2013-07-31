angular.module('account').run [
  '$rootScope'
  ($rootScope) ->

    $rootScope.$on 'register:success', (ev, user) ->
      $rootScope.redirect_to "#{user.user_type.toLowerCase()}.profile", success: 'You are registered and logged in'

    $rootScope.$on 'login:success', (ev, user)->
      $rootScope.redirect_to "#{user.user_type.toLowerCase()}.profile", success: 'You are logged in'

    $rootScope.$on 'logged_out', ->
      $rootScope.redirect_to 'home', success: 'You are logged out'
]
