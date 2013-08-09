angular.module('account').controller 'AccountEmailConfirmationCtrl', [
  '$scope'
  '$routeParams'
  '$http'
  'Auth'
  'ServiceEndpoint'
  ($scope, $routeParams, $http, Auth, ServiceEndpoint) ->

    $http.get("#{ServiceEndpoint}/users/activate_from_email/#{$routeParams.userId}/#{$routeParams.token}")
    .success( (authenticated)->
      $scope.notify_success 'Your email has been verified'
      Auth.create_session {
        user_type: authenticated.user_type,
        auth_id: authenticated.auth_id,
        auth_provider: authenticated.auth_provider,
        token: authenticated.token
      }
    ).error ->
      $scope.notify_error 'We are unable to activate this account.'

    $scope.$on 'session:created', (ev, user) ->
      $scope.attemptLogin().then ( ->
        $scope.redirect_to "${user.user_type.toLowerCase()}.profile.edit", success: 'Please proceed to furnish your account information'
      ), ->
        $scope.notify_error 'Unable to log you in'
]
