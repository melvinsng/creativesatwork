angular.module('dashboard').controller 'DashboardEmployerProfileCtrl', [
  '$scope'
  ($scope) ->

    $scope.hasError = (input) ->
      !input.$valid && (input.$dirty || $scope.submitted)

    $scope.submitForm = ->
      $scope.submitted = true
      if $scope.form.$valid
        $scope.clear_notifications()
        $scope.current_user.put().then ((current_user)->
          $scope.current_user = current_user
          $scope.success_notification 'Your profile is updated successfully'
        ), ->
          $scope.error_notification 'Form has missing or invalid values'
      else
        $scope.error_notification 'Form has missing or invalid values'

    init = ->
      $scope.submitted = false
    init()

]