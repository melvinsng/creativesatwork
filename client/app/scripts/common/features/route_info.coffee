angular.module('common').run [
  '$rootScope'
  '$location'
  ($rootScope, $location) ->

    $rootScope.current_route = '/'

    $rootScope.$on '$routeChangeSuccess', ->
      $rootScope.current_route = $location.path()

    $rootScope.$on "$locationChangeStart", (event, newUrl, oldUrl) ->
      #console.log 'location change'
      #console.log newUrl
      #console.log oldUrl
      #event.preventDefault()  if newUrl is $location.absUrl()

    $rootScope.getNavClass = (path) ->
      if $rootScope.current_route.substring(0, path.length) == path
        return 'active'
      else
        return ''

]
