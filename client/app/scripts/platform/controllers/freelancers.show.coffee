angular.module('platform').controller 'FreelancersShowCtrl', [
  '$scope'
  'freelancer'
  ($scope, freelancer) ->
    $scope.freelancer = freelancer
    console.log freelancer
]