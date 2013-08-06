angular.module('dashboard').directive 'freelancerBidProjects', [
  ->
    restrict: 'E'
    replace: true
    scope:
      projects: '='
    templateUrl: 'partials/dashboard/freelancer.bid_projects.html'
]