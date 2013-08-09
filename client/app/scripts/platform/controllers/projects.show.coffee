angular.module('platform').controller 'ProjectsShowCtrl', [
  '$scope'
  'project'
  'Project'
  ($scope, project, Project) ->

    $scope.project = project
    $scope.userOffered = _.contains project.offer_ids, $scope.current_user.id
    $scope.userBidded = _.contains project.bidder_ids, $scope.current_user.id
    $scope.userEmployed = project.freelancer_id == $scope.current_user.id
    $scope.userIsEmployer = project.employer_id == $scope.current_user.id

    $scope.bidProject = ->
      Project.add_bidder(project.id, $scope.current_user.id).then ->
        $scope.userOffered = false
        $scope.userBidded = true
        $scope.notify_success 'Your bid has been placed'
      , (res) ->
        console.log res
        $scope.notify_error 'Something wrong..'

    $scope.deleteProject = ->
      promise = Project.destroy project.id, delegate: true
      promise.then ->
        $scope.redirect_to 'projects', success: 'Your project is deleted'
      , ->
        $scope.notify_error 'Unable to delete this project'

    $scope.acceptOffer = ->
      Project.accept_offer(project.id, $scope.current_user.id).then ->
        $scope.userOffered = false
        $scope.userBidded = false
        $scope.userEmployed = true
        $scope.notify_success 'You accepted the offer. Thank you'
      , (res) ->
        console.log res
        $scope.notify_error 'Something wrong...'

    $scope.acceptBid = (user_id)->
      Project.accept_offer(project.id, user_id).then ->
        $scope.userOffered = false
        $scope.userBidded = false
        $scope.notify_success 'You accepted the bid. Thank you'
      , (res) ->
        console.log res
        $scope.notify_error 'Something wrong...'

]