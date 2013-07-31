angular.module('projects').controller 'ProjectsNewCtrl', [
  '$scope'
  'Project'
  '$location'
  ($scope, Project, $location) ->

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
    #$scope.project = {
    #  organizer_id: $scope.current_user._id.$oid
    #}

    $scope.project =
      organizer_id: $scope.current_user.id
      project_leaders: [
        name: ""
        contact_number: ""
      ]
      project_photos: []
#      name: "Mega Like"
#      contact_person: "Felix Tioh"
#      contact_person_number: "98192812"
#      contact_person_email: "felixsagitta@gmail.com"
#      first_objective: "We the Citizens"
#      objective_summary: "Yojasd"
#      target_audience: "Kids"
#      video_url: "http://www.youtube.com/watch?v=aQMssDmh54o"


    $scope.project.project_leaders = [{
      name: '',
      contact_number: ''
    }]
    $scope.project.project_photos = []
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
      promise = Project.create $scope.project, delegate: true
      promise.then ((project)=>
        $scope.redirect_to "/projects.show/#{project.id}", success: "Project created successfully"
      ), (response) =>
        $scope.error_notification "Project failed to create"
        console.log response
]