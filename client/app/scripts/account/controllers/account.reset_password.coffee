angular.module('account').controller 'AccountResetPasswordCtrl', [
  '$scope'
  '$routeParams'
  'User'
  ($scope, $routeParams, User) ->

    $scope.submitForm = (new_password)->
      User.reset_password_with_token($routeParams.userId, $routeParams.token, new_password)
      .then ( ->
        $scope.redirect_to 'user.login', success: 'Your password is changed successfully. Please login'
      ), ->
        $scope.error_notification 'Unable to reset password. Token is invalid.'
]
