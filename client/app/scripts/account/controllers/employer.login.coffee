angular.module('account').controller 'EmployerLoginCtrl', [
  '$scope'
  'Auth'
  'CustomProvider'
  '$dialog'
  'RememberMe'
  ($scope, Auth, CustomProvider, $dialog, RememberMe) ->

    $scope.linkedinConnect = ->
      CustomProvider.connect('linkedin', 'Employer', 'employer')

    $scope.submitForm = ->
      if $scope.remember_me
        RememberMe.set($scope.user.email)
      else
        RememberMe.destroy()
      $scope.clear_notifications()
      Auth.authenticate('Employer', $scope.user.email, 'local', $scope.user.password)

    $scope.forgotPassword = ->
      $dialog.dialog().open('dialogs/account.forgot_password.html').then (result) ->
        if result?
          Auth.forgot_password('Employer', result, 'local')

    if not $scope.user
      $scope.user = {}

    if not RememberMe.isEmpty()
      if RememberMe.email
        $scope.user.email = RememberMe.email
]