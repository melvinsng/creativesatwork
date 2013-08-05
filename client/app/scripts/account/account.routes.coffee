angular.module('account').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).setTemplatePrefix('views/account')
    .when('freelancer.login')
    .when('freelancer.login.custom_provider')
    .when('freelancer.register')
    .when('freelancer.register.custom_provider')
    .when('employer.login')
    .when('employer.login.custom_provider')
    .when('employer.register')
    .when('employer.register.custom_provider')
    .when('account.email_confirmation/:userId/:token', omitView: true)
    .when('account.reset_password/:userId/:token')
]
