angular.module('projects').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).setTemplatePrefix('views/projects')
    .when('projects.new', user: true)
    .when('projects.show/:id', resolves: ['project'])
    .when('projects.edit/:id', resolves: ['project'])
    .when('projects.volunteers/:id', resolves: ['project'])
    .when('projects.list/:objId', resolves: ['projects'])
]
