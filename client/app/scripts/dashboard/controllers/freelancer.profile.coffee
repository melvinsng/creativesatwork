angular.module('account').controller 'DashboardFreelancerProfileCtrl', [
  '$scope'
  ($scope) ->

    console.log $scope.current_user.skills
    $scope.submitForm = ->
      $scope.clear_notifications()
      $scope.current_user.put().then ((current_user)->
        $scope.success_notification 'Your profile is updated successfully'
        current_user
      ), ->
        $scope.error_notification 'Unable to update user'
]