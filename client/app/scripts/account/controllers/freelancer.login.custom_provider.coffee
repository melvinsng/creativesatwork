angular.module('account').controller 'UserLoginCustomProviderCtrl', [
  '$scope'
  'Auth'
  'MemoryStore'
  ($scope, Auth, MemoryStore) ->

    info = MemoryStore.get('auth_info')
    $scope.user = info
    MemoryStore.clear()

    $scope.submitForm = ->
      $scope.clear_notifications()
      Auth.authenticate('CommonUser', $scope.user.auth_id, $scope.user.auth_provider, $scope.user.password)

    $scope.forgotPassword = ->
      $dialog.dialog().open('dialogs/account.forgot_password.html').then (result) ->
        if result?
          Auth.forgot_password('CommonUser', result, $scope.user.auth_provider)
]