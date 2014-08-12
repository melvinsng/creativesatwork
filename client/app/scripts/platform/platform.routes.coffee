angular.module('platform').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).set_template_prefix('views/platform')
    .when('projects.show/:id', resolves: ['project'], user: true)
    .when('projects', resolves: ['job_categories'])
    .when('freelancers.show/:id', resolves: ['freelancer'], user: true)
    .when('freelancers', resolves: ['job_categories'])
]
