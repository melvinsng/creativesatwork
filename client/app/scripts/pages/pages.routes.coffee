angular.module('pages').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).setTemplatePrefix('views/pages')
    .when('home')
    #.when('home', resolves: ['projects'])
]
