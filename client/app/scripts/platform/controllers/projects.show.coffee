angular.module('platform').controller 'ProjectsShowCtrl', [
  '$scope'
  'project'
  'job_categories'
  ($scope, project, job_categories) ->
    console.log project
    console.log job_categories
    $scope.project = project
    $scope.job_categories = job_categories
]