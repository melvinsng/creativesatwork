angular.module('platform').controller 'ProjectsShowCtrl', [
  '$scope'
  'project'
  'Project'
  ($scope, project, Project) ->
    console.log project
    $scope.project = project
    console.log project.bidders
    console.log project.offers

    $scope.bidProject = ->
      Project.add_bidder(project.id, $scope.current_user.id).then (res) ->
        console.log res
        $scope.notify_success 'Your bid has been placed'
      , (res) ->
        console.log res
        $scope.notify_error 'Something wrong..'
]