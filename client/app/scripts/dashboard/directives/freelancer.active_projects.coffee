angular.module('dashboard').directive 'freelancerActiveProjects', [
  ->
    restrict: 'E'
    replace: true
    scope:
      projects: '@'
    templateUrl: 'partials/dashboard/freelancer.active_projects.html'
]