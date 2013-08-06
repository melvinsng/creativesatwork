angular.module('dashboard').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).setTemplatePrefix('views/dashboard')
    .when('dashboard.employer', omitController: true)
    .when('dashboard.employer.notifications', omitController: true)
    .when('dashboard.employer.completed_projects', omitController: true)
    .when('dashboard.employer.pending_projects', omitController: true)
    .when('dashboard.employer.active_projects', omitController: true)
    .when('dashboard.employer.profile', user: true)
    .when('dashboard.create_project', user:true, resolves: ['job_categories'])
    .when('dashboard.freelancer', omitController: true)
    .when('dashboard.freelancer.notifications', omitController: true)
    .when('dashboard.freelancer.completed_projects', omitController: true)
    .when('dashboard.freelancer.bid_projects', omitController: true)
    .when('dashboard.freelancer.active_projects', omitController: true)
    .when('dashboard.freelancer.profile', user: true, resolves: ['job_categories'])
]
