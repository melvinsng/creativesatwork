angular.module('account').controller 'UserLoginCtrl', [
  '$scope'
  'Auth'
  'CustomProvider'
  '$dialog'
  ($scope, Auth, CustomProvider, $dialog) ->

    $scope.facebookConnect = ->
      CustomProvider.connect('facebook', 'CommonUser')

    $scope.submitForm = ->
      $scope.clear_notifications()
      Auth.authenticate('CommonUser', $scope.user.email, 'local', $scope.user.password)

    $scope.forgotPassword = ->
      $dialog.dialog().open('dialogs/account.forgot_password.html').then (result) ->
        if result?
          Auth.forgot_password('CommonUser', result, 'local')


]