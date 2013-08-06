angular.module('dashboard').directive 'freelancerCompletedProjects', [
  ->
    restrict: 'E'
    replace: true
    scope:
      projects: '='
    templateUrl: 'partials/dashboard/freelancer.completed_projects.html'
]