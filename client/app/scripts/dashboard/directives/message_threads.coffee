angular.module('dashboard').directive 'messageThreads', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/dashboard/message_threads.html'
    controller: [
      '$scope'
      '$rootScope'
      'Message'
      ($scope, $rootScope, Message) ->
        #alert $rootScope.current_user.id
        promise = Message.get_threads $rootScope.current_user.id
        promise.then (threads) ->
          console.log threads
          $scope.threads = threads
    ]
]