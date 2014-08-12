angular.module('common').run [
  '$rootScope'
  '$location'
  ($rootScope, $location) ->

    $rootScope.$on '$routeChangeSuccess', ->
      ga 'send', 'pageview', $location.path()
      console.log $location.path()

]
