angular.module('dashboard').controller 'DashboardEmployerProfileCtrl', [
  '$scope'
  '$rootScope'
  ($scope, $rootScope) ->

    $scope.hasError = (input) ->
      !input.$valid && (input.$dirty || $scope.submitted)

    $scope.submitForm = ->
      $scope.submitted = true
      if $scope.form.$valid
        $scope.clear_notifications()
        $rootScope.current_user.put().then ((current_user)->
          $rootScope.current_user = current_user
          $scope.notify_success 'Your profile is updated successfully'
        ), ->
          $scope.notify_error 'Form has missing or invalid values'
      else
        $scope.notify_error 'Form has missing or invalid values'

    init = ->
      $scope.submitted = false
    init()

]