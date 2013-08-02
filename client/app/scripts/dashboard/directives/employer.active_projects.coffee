angular.module('dashboard').directive 'employerActiveProjects', [
  ->
    restrict: 'E'
    replace: true
    scope:
      projects: '@'
    templateUrl: 'partials/dashboard/employer.active_projects.html'
]