angular.module('platform').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).setTemplatePrefix('views/platform')
    .when('projects.show/:id', resolves: ['project', 'job_categories'])
    .when('projects.edit/:id', resolves: ['project', 'job_categories'])
    .when('projects', resolves: ['job_categories'])
    .when('freelancers.show/:id', resolves: ['freelancer', 'job_categories'])
    .when('freelancers', resolves: ['job_categories'])
]
