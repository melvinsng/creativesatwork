angular.module('platform').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).setTemplatePrefix('views/platform')
    .when('projects.new')
    .when('projects.show/:id')
    .when('projects.edit/:id')
    .when('projects')
    .when('freelancers.show/:id', resolves: ['freelancer', 'job_categories'])
]
