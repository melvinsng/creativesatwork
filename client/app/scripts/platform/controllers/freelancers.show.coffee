angular.module('platform').controller 'FreelancersShowCtrl', [
  '$scope'
  'freelancer'
  'job_categories'
  ($scope, freelancer, job_categories) ->
    $scope.freelancer = freelancer
    $scope.job_categories = job_categories
]