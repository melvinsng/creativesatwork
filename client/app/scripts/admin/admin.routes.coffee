angular.module('admin').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider
    .simplify($routeProvider)
    .require_admin()
    .set_template_prefix('views/admin')
    .when('admin.login', omitController: true, admin: false)
    .when('admin.users', resolves: ['job_categories'])
    .when('admin.employers')
]
