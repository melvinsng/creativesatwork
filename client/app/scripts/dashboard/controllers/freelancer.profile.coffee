angular.module('account').controller 'DashboardFreelancerProfileCtrl', [
  '$scope'
  'job_categories'
  ($scope, job_categories) ->

    $scope.$on 'fileupload:add', ->
      $scope.$apply ->
        $scope.avatar_upload_state = 'Uploading...'

    $scope.$on 'fileupload:done', (e, data) ->
      $scope.success_notification 'Profile picture updated'
      url = data.data.result?.data?.avatar?.url
      if url?
        $scope.$apply ->
          $scope.avatar_upload_state = ''
          $scope.current_user.photo_url = data.domain + url
          $scope.current_user.put().then ((current_user) ->
            $scope.success_notification 'New profile picture saved.'
            $scope.$apply()
          ), ->
            $scope.error_notification 'Unable to change profile picture'

    $scope.$on 'fileupload:failed', ->
      $scope.error_notification 'Upload failed', false

    $scope.hasError = (input) ->
      !input.$valid && (input.$dirty || $scope.submitted)

    $scope.submitForm = ->
      $scope.submitted = true
      if $scope.form.$valid
        $scope.clear_notifications()
        $scope.current_user.put().then ((current_user)->
          $scope.current_user = current_user
          $scope.redirect_to "freelancers.show/#{current_user.id}", success: 'Your profile is updated successfully'
        ), ->
          $scope.error_notification 'Form has missing or invalid values'
      else
        $scope.error_notification 'Form has missing or invalid values'

    init = ->
      $scope.submitted = false
      $scope.job_categories = job_categories
    init()

]