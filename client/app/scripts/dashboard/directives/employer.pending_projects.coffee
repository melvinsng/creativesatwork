angular.module('dashboard').directive 'employerPendingProjects', [
  ->
    restrict: 'E'
    replace: true
    scope:
      projects: '='
    templateUrl: 'partials/dashboard/employer.pending_projects.html'
]