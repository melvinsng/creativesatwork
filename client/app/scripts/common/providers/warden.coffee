angular.module('common').provider 'Warden', ->
  class Warden
    $get: ->
      # no-op

    simplify: (routeProvider) ->
      @routeProvider = routeProvider
      return @

    setTemplatePrefix: (prefix) ->
      @templatePrefix = prefix
      if prefix[-1..-1] != '/'
        @templatePrefix += '/'
      return @

    # available options are
    #   `route`: for custom routes
    #   `user`: require user to be logged in to access this route
    #   `resolves`
    when: (route, options={}) ->
      if route[0..0] == '/'
        route = route[1..-1]
      cleanRoute = route.split('/')[0]
      controllerTokens = (token.capitalize() for token in cleanRoute.split(/\.|_/))
      routeStr = options.route || "/#{route}"
      controller = "#{controllerTokens.join('')}Ctrl"
      templateUrl = "#{@templatePrefix}#{cleanRoute}.html"

      resolves = {}
      if options.user? and options.user
        resolves.current_user = resolvables['current_user']
      if options.resolves?
        resolves[resolve] = resolvables[resolve] for resolve in options.resolves
      if options.omitView? and options.omitView
        templateUrl = 'views/pages/empty.html'
      if options.templateUrl?
        templateUrl = options.templateUrl
      if options.omitController? and options.omitController
        @routeProvider.when routeStr, templateUrl: templateUrl, resolve: resolves
      else
        @routeProvider.when routeStr, templateUrl: templateUrl, controller: controller, resolve: resolves
      return @

  new Warden

