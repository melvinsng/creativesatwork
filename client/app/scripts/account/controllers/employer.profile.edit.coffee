angular.module('account').controller 'EmployerProfileEditCtrl', [
  '$scope'
  ($scope) ->

    $scope.submitForm = ->
      $scope.clear_notifications()
      $scope.current_user.put().then ((current_user)->
        $scope.redirect_to 'employer.profile.edit', success: 'Your profile is updated successfully'
        current_user
      ), ->
        $scope.error_notification 'Unable to update user'
]