angular.module('common').run [
  '$rootScope'
  '$timeout'
  '$location'
  ($rootScope, $timeout, $location) ->

    $rootScope.redirect_to = (path, options={}) ->
      path = path.replace(/^\//,'')
      $rootScope.success_notification options.success if options.success?
      $rootScope.info_notification options.info if options.info?
      $rootScope.error_notification options.error if options.error?
      $location.path "/#{path}"

]
