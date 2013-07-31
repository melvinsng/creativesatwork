angular.module('account').controller 'EmployerLoginCustomProviderCtrl', [
  '$scope'
  'Auth'
  'MemoryStore'
  ($scope, Auth, MemoryStore) ->

    info = MemoryStore.get('auth_info')
    $scope.user = info
    MemoryStore.clear()

    $scope.submitForm = ->
      $scope.clear_notifications()
      Auth.authenticate('Employer', $scope.user.auth_id, $scope.user.auth_provider, $scope.user.password)

    $scope.forgotPassword = ->
      $dialog.dialog().open('dialogs/account.forgot_password.html').then (result) ->
        if result?
          Auth.forgot_password('Employer', result, $scope.user.auth_provider)
]