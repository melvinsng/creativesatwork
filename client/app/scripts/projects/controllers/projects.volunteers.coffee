angular.module('projects').controller 'ProjectsVolunteersCtrl', [
  '$scope'
  'project'
  'Auth'
  'Project'
  ($scope, project, Auth, Project) ->

    $scope.project = project

    authenticated = Auth.user delegate: true
    authenticated.then (user) ->
      $scope.user = user

]