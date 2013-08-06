angular.module('dashboard').controller 'DashboardEmployerCtrl', [
  '$scope'
  'EmployerProjects'
  ($scope, EmployerProjects) ->
    $scope.pending_projects = EmployerProjects.pending_projects()
    $scope.active_projects = EmployerProjects.active_projects()
    $scope.completed_projects = EmployerProjects.completed_projects()
    $scope.pending_projects_count = EmployerProjects.pending_projects_count()
    $scope.active_projects_count = EmployerProjects.active_projects_count()
    $scope.completed_projects_count = EmployerProjects.completed_projects_count()
]