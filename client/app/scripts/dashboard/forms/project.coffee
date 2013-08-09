angular.module('dashboard').directive 'projectForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {
      type: '@'
      user: '@'
    }
    templateUrl: 'partials/dashboard/forms.project.html'
    controller: [
      '$scope'
      'JobCategory'
      'Project'
      '$rootScope'
      '$routeParams'
      ($scope, JobCategory, Project, $rootScope, $routeParams) ->

        $scope.hasError = (input) ->
          !input.$valid && (input.$dirty || $scope.submitted)

        $scope.submitForm = ->
          $scope.submitted = true
          if $scope.form.$valid
            $rootScope.clear_notifications()
            promise = Project.create $scope.project, notify_success: false
            promise.then ((project)->
              $rootScope.redirect_to "projects.show/#{project.id}" ,success: 'Your project is created successfully'
            ), ->
              $rootScope.notify_error 'Form has missing or invalid values'
          else
            $rootScope.notify_error 'Form has missing or invalid values'

        init = ->
          $scope.submitted = false
          $scope.job_categories = JobCategory.all()
          switch $scope.type
            when 'new'
              $scope.project =
                employer_id: $scope.user.id
            when 'edit'
              Project.find($routeParams.id).then (project) ->
                $scope.project = project
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
]