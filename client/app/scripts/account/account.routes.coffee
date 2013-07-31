angular.module('account').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).setTemplatePrefix('views/account')
    .when('freelancer.login')
    .when('freelancer.login.custom_provider')
    .when('freelancer.register')
    .when('freelancer.register.custom_provider')
    .when('freelancer.profile', user: true)
    .when('freelancer.profile.edit', user: true)
    .when('employer.login')
    .when('employer.login.custom_provider')
    .when('employer.register')
    .when('employer.register.custom_provider')
    .when('employer.profile', user: true)
    .when('employer.profile.edit', user: true)
    .when('account.email_confirmation/:userId/:token', omitView: true)
    .when('account.reset_password/:userId/:token')
]
