angular.module('platform').controller 'FreelancersShowCtrl', [
  '$scope'
  'freelancer'
  'Project'
  'CommonApi'
  ($scope, freelancer, Project, CommonApi) ->
    $scope.freelancer = freelancer

    $scope.offerProject = ->
      Project.add_offer($scope.offering_project_id, freelancer.id).then (res)->
        console.log res
        $scope.notify_success 'Project offered'
      , (response) ->
        console.log response
        console.log 'failed 102'

    $scope.submitQuestionToAdmin = ->
      if $scope.question_from_employer
        CommonApi.submit_question_about_freelancer_to_admin($scope.question_from_employer, freelancer.id, $scope.current_user.id).then ->
          $scope.notify_success 'Question submitted successfully.'
        , (res) ->
          console.log res
          console.log 'failed 103'
      else
        $scope.notify_info 'Please fill in the form..'

]