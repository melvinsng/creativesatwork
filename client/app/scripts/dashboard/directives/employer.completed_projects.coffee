angular.module('dashboard').directive 'employerCompletedProjects', [
  ->
    restrict: 'E'
    replace: true
    scope:
      projects: '@'
    templateUrl: 'partials/dashboard/employer.completed_projects.html'
]