angular.module('account').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).setTemplatePrefix('views/account')
    .when('user.login')
    .when('user.login.custom_provider')
    .when('user.register')
    .when('user.register.custom_provider')
    .when('user.profile', user: true)
    .when('user.profile.edit', user: true)
    .when('account.email_confirmation/:userId/:token', omitView: true)
    .when('account.reset_password/:userId/:token')
]
