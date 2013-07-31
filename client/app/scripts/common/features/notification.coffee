# do not overload rootScope, use rootScope as event dispatcher/broadcaster only

angular.module('common').run [
  '$rootScope'
  ($rootScope) ->

    $rootScope.info_notification = (msg, append=false) ->
      if not append
        $rootScope.$broadcast('notification:clear')
      $rootScope.$broadcast('notification:info', msg)

    $rootScope.error_notification = (msg, append=true) ->
      if not append
        $rootScope.$broadcast('notification:clear')
      $rootScope.$broadcast('notification:error', msg)

    $rootScope.success_notification = (msg, append=false) ->
      if not append
        $rootScope.$broadcast('notification:clear')
      $rootScope.$broadcast('notification:success', msg)

    $rootScope.clear_notifications = ->
      $rootScope.$broadcast('notification:clear')

]
