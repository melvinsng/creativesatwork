angular.module('platform').controller 'ProjectsShowCtrl', [
  '$scope'
  'project'
  'Project'
  ($scope, project, Project) ->

    $scope.project = project

    $scope.bidProject = ->
      Project.add_bidder(project.id, $scope.current_user.id).then (res) ->
        console.log res
        $scope.notify_success 'Your bid has been placed'
      , (res) ->
        console.log res
        $scope.notify_error 'Something wrong..'

    $scope.deleteProject = ->
      promise = Project.destroy project.id, delegate: true
      promise.then ->
        $scope.redirect_to 'projects', success: 'Your project is deleted'
      , ->
        $scope.notify_error 'Unable to delete this project'
]