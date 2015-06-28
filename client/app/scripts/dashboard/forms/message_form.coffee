angular.module('platform').directive 'messageForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {
      sender: '='
      recipient: '='
    }
    templateUrl: 'forms/dashboard/message.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'FormHandler'
      'Message'
      '$q'
      ($scope, $rootScope, $routeParams, FormHandler, Entity, $q) ->

        submitForm = =>
          promise = Entity.create $scope.form_object, notify_success: false
          success_msg = 'Message has been sent'
          promise.then ((object)->
            $rootScope.notify_success success_msg
            $scope.closeForm()
            $scope.$emit 'repull_messages'
          ), ->
            $rootScope.notify_error 'Form has missing or invalid values'

        $scope.submitMessage = =>
          $scope.submitted = true
          if $scope.form_object.content
            if $scope.form.$valid
              $rootScope.clear_notifications()
              submitForm()
            else
              FormHandler.validate $scope.form.$error, false
          else
            $rootScope.notify_error 'You are sending an empty message.'

        $scope.closeForm = ->
          $scope.form_object =
            sender_id: $scope.sender.id
            recipient_id: $scope.recipient.id
            content: ''
            message_attachments: []

        $scope.$on 'fileupload:add', (e, data)->
          $scope.$apply ->
            $scope.message_attachment_state = 'Uploading...'

        $scope.$on 'fileupload:done', (e, response) ->
          console.log response
          url = response.data.result?.url
          filename = response.data.result?.filename
          console.log url
          if url?
            $scope.$apply ->
              $scope.message_attachment_state = ''
              $scope.form_object.message_attachments.push {
                url: url
                filename: filename
              }
          else
            $scope.message_attachment_state = ''
            $scope.notify_error 'Upload failed', false

        $scope.$on 'fileupload:failed', ->
          $scope.message_attachment_state = ''
          $scope.notify_error 'Upload failed', false

        $scope.removeAttachment = (index) ->
          $scope.form_object.message_attachments.splice(index,1)

        init = ->
          FormHandler.formify $scope
          $scope.form_object =
            sender_id: $scope.sender.id
            recipient_id: $scope.recipient.id
            content: ''
            message_attachments: []

        init()
    ]
]