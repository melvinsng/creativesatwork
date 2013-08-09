angular.module('dashboard').controller 'DashboardCreateProjectCtrl', [
  '$scope'
  'job_categories'
  'Project'
  ($scope, job_categories, Project) ->

    $scope.hasError = (input) ->
      !input.$valid && (input.$dirty || $scope.submitted)

    $scope.submitForm = ->
      $scope.submitted = true
      if $scope.form.$valid
        $scope.clear_notifications()
        promise = Project.create $scope.project, notify_success: false
        promise.then ((project)->
          $scope.redirect_to "projects.show/#{project.id}" ,success: 'Your project is created successfully'
        ), ->
          $scope.error_notification 'Form has missing or invalid values'
      else
        $scope.error_notification 'Form has missing or invalid values'

    init = ->
      $scope.submitted = false
      $scope.job_categories = job_categories
      $scope.project =
        employer_id: $scope.current_user.id
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