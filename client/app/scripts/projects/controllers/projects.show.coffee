angular.module('projects').controller 'ProjectsShowCtrl', [
  '$scope'
  'project'
  'Auth'
  'Project'
  '$dialog'
  ($scope, project, Auth, Project, $dialog) ->

    $scope.project = project

    authenticated = Auth.user delegate: true
    authenticated.then (user) ->
      $scope.user = user
      $scope.volunteered = _.contains($scope.project.volunteer_ids, user.id)
      $scope.supported = _.contains($scope.project.supporter_ids, user.id)

    $scope.support = ->
      if $scope.user?
        if $scope.supported
          $scope.info_notification 'You have already supported this project.'
        else
          promise = Project.add_supporter($scope.project.id, $scope.user.id)
          promise.then (->
            $scope.supported = true
            $scope.project.no_of_supporters += 1
            $scope.success_notification 'Thank you for your support'
          ), (response) ->
            console.log response
            $scope.error_notification 'Unable to perform this action. Please contact system administrator'
      else
        $scope.info_notification "You need to login or register in order to participate"

    $scope.volunteer = ->

      if $scope.user?
        if $scope.volunteered
          $scope.info_notification 'You have already volunteered for this project.'
        else
          $dialog.dialog().open('dialogs/projects.volunteers.request_mobile_number.html').then (result) ->
            $scope.user.phone = result
            $scope.user.put().then ( (response)->
              promise = Project.add_volunteer($scope.project.id, $scope.user.id)
              promise.then ( ->
                $scope.volunteered = true
                $scope.project.no_of_volunteers += 1
                $scope.success_notification 'Thank you for your support'
              ), (response) ->
                console.log response
                $scope.error_notification 'Unable to perform this action. Please contact system administrator'
            ), (response)->
              console.log response
      else
        $scope.info_notification "You need to login or register in order to participate"



]