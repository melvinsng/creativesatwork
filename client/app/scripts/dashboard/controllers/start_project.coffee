angular.module('dashboard').controller 'DashboardCreateProjectCtrl', [
  '$scope'
  'job_categories'
  ($scope, job_categories) ->

    $scope.hasError = (input) ->
      !input.$valid && (input.$dirty || $scope.submitted)

    $scope.submitForm = ->
      $scope.submitted = true
      if $scope.form.$valid
        $scope.clear_notifications()
        $scope.current_user.put().then ((current_user)->
          $scope.current_user = current_user
          $scope.success_notification 'Your project is created successfully'
        ), ->
          $scope.error_notification 'Form has missing or invalid values'
      else
        $scope.error_notification 'Form has missing or invalid values'

    init = ->
      $scope.submitted = false
      $scope.job_categories = job_categories
      $scope.budget_ranges = [
        '$0 - $500'
        '$500 - $1000'
        '$1000 - $2000'
        '$2000 - $3000'
        '$3000 - $5000'
        '$5000 - $10000'
      ]
    init()

]