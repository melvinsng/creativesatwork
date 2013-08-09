angular.module('dashboard').controller 'DashboardFreelancerProfileCtrl', [
  '$scope'
  'job_categories'
  ($scope, job_categories) ->

    $scope.$on 'fileupload:add', ->
      $scope.$apply ->
        $scope.avatar_upload_state = 'Uploading...'

    $scope.$on 'fileupload:done', (e, data) ->
      $scope.notify_success 'Profile picture updated'
      url = data.data.result?.data?.avatar?.url
      if url?
        $scope.$apply ->
          $scope.avatar_upload_state = ''
          $scope.current_user.photo_url = data.domain + url
          $scope.current_user.put().then ((current_user) ->
            $scope.notify_success 'New profile picture saved.'
            $scope.$apply()
          ), ->
            $scope.notify_error 'Unable to change profile picture'

    $scope.$on 'fileupload:failed', ->
      $scope.notify_error 'Upload failed', false

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
          $scope.notify_error 'Form has missing or invalid values'
      else
        $scope.notify_error 'Form has missing or invalid values'

    init = ->
      $scope.submitted = false
      $scope.job_categories = job_categories
    init()

]