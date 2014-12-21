angular.module('dashboard').controller 'DashboardMessagesCtrl', [
  '$scope'
  'Message'
  '$rootScope'
  '$route'
  'recipient'
  ($scope, Message, $rootScope, $route, recipient) ->
    $scope.sender = $rootScope.current_user
    $scope.recipient = recipient
    #alert $rootScope.current_user.id
    #alert(user_id)

    $scope.sent_messages_query =
      order: 'created_at DESC'
      conditions:
        recipient_id: recipient.id
        sender_id: $rootScope.current_user.id

    $scope.received_messages_query =
      order: 'created_at DESC'
      conditions:
        recipient_id: $rootScope.current_user.id
        sender_id: recipient.id

    $scope.populateSentMessagesThenReceivedMessages = ->
      Message.all($scope.sent_messages_query).then ((sent_messages) ->
        $scope.sent_messages = sent_messages
        $scope.populateReceivedMessagesThenJoin()
      ), ->
        $scope.notify_error 'Unable to fetch result from server'

    $scope.populateReceivedMessagesThenJoin = ->
      Message.all($scope.received_messages_query).then ((received_messages) ->
        $scope.received_messages = received_messages
        $scope.joinMessages()
      ), ->
        $scope.notify_error 'Unable to fetch result from server'

    $scope.joinMessages = ->
      console.log($scope.received_messages)
      console.log($scope.sent_messages)
      messages = $scope.received_messages.concat $scope.sent_messages
      messages = _.sortBy messages, (m) ->
        m.updated_at
      $scope.messages = messages.reverse()

    $scope.$on 'repull_messages', ->
      $scope.populateSentMessagesThenReceivedMessages()

    init = ->
      $scope.populateSentMessagesThenReceivedMessages()

    init()
]