angular.module('account').controller 'FreelancerProfileEditCtrl', [
  '$scope'
  ($scope) ->

    $scope.current_user._skills = (skill.name for skill in $scope.current_user.skills)

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

    $scope.submitForm = ->
      $scope.current_user.skills = ({name} for name in $scope.current_user._skills)
      $scope.clear_notifications()
      $scope.current_user.put().then ((current_user)->
        $scope.redirect_to 'freelancer.profile.edit', success: 'User updated successfully'
        current_user
      ), ->
        $scope.error_notification 'Unable to update user'
]