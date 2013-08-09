angular.module('dashboard').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).set_template_prefix('views/dashboard')
    .require_user().omit_controller()
    .when('dashboard.employer')
    .when('dashboard.employer.notifications')
    .when('dashboard.employer.completed_projects')
    .when('dashboard.employer.pending_projects')
    .when('dashboard.employer.active_projects')
    .when('dashboard.employer.profile', omitController: false)
    .when('dashboard.create_project', resolves: ['job_categories'])
    .when('dashboard.freelancer')
    .when('dashboard.freelancer.notifications')
    .when('dashboard.freelancer.offered_projects')
    .when('dashboard.freelancer.bid_projects')
    .when('dashboard.freelancer.active_projects')
    .when('dashboard.freelancer.profile', omitController: false, resolves: ['job_categories'])
]
