angular.module('platform').controller 'ProjectsShowCtrl', [
  '$scope'
  'project'
  'Project'
  'job_categories'
  ($scope, project, Project, job_categories) ->
    console.log project
    console.log job_categories
    $scope.project = project
    console.log project.bidders
    console.log project.offers
    $scope.job_categories = job_categories

    $scope.bidProject = ->
      Project.add_bidder(project.id, $scope.current_user.id).then (res) ->
        console.log res
        $scope.success_notification 'Your bid has been placed'
      , (res) ->
        console.log res
        $scope.error_notification 'Something wrong..'
]