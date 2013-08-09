angular.module('platform').controller 'FreelancersShowCtrl', [
  '$scope'
  'freelancer'
  'Project'
  'job_categories'
  ($scope, freelancer, Project, job_categories) ->
    $scope.freelancer = freelancer
    $scope.job_categories = job_categories

    $scope.offerProject = ->
      Project.add_offer($scope.offering_project_id, freelancer.id).then (res)->
        console.log res
        $scope.notify_success 'Project offered'
      , (response) ->
        console.log response
        alert 'fai'
]