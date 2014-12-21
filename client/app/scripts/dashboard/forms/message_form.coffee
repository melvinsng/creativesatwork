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

        init = ->
          FormHandler.formify $scope
          $scope.form_object =
            sender_id: $scope.sender.id
            recipient_id: $scope.recipient.id
            content: ''


        init()
    ]
]