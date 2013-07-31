angular.module('projects').controller 'ProjectsEditCtrl', [
  '$scope'
  'project'
  '$location'
  ($scope, project, $location) ->

    $scope.objectives = [
      'We the Citizens'
      'Pledge ourselves as one united people'
      'Regardless of Race, Language or Religion'
      'To build a democratic society'
      'Based on Justice and Equality'
      'To achieve happiness'
      'Prosperity'
      'Progress for our Nation'
    ]

    $scope.organizer = $scope.current_user

    $scope.project = project
    $scope.project.organizer_id = $scope.organizer.id

    $scope.addProjectLeader = ->
      $scope.project.project_leaders.push {
        name: '',
        contact_number: ''
      }
    $scope.removeProjectLeader = (index) ->
      $scope.project.project_leaders.splice(index,1)

    $scope.removeProjectPhoto = (index) ->
      $scope.project.project_photos.splice(index,1)


    $scope.$on 'fileupload:add', (e, data)->
      $scope.$apply ->
        switch data.id
          when 'photo-uploader'
            $scope.photo_upload_state = 'Uploading...'
          when 'logo-uploader'
            $scope.logo_upload_state = 'Uploading...'

    $scope.$on 'fileupload:done', (e, data) ->
      $scope.$apply ->
        url = data.data.result?.data?.content?.url
        if url?
          switch data.id
            when 'photo-uploader'
              $scope.photo_upload_state = ''
              $scope.project.project_photos.push {
                url: data.domain + url
              }
            when 'logo-uploader'
              $scope.logo_upload_state = ''
              $scope.project.organization_logo = data.domain + url


    $scope.$on 'fileupload:failed', ->
      $scope.error_notification 'Upload failed', false


    $scope.submitForm = ->
      $scope.clear_notifications()
      $scope.project.put().then ((current_user)->
        $scope.redirect_to "/projects.show/#{project.id}", success: 'Project updated'
        current_user
      ), ->
        $scope.error_notification 'Unable to update project'
]