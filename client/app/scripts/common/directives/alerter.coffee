angular.module('common').directive 'alerter', [
  ->
    restrict: 'E'
    replace: true
    scope:
      closeCountDown: '@'
    templateUrl: 'partials/common/alerter.html'
    controller: [
      '$scope'
      '$timeout'
      ($scope, $timeout) ->
        $scope.alerts = []

        clearAlertTimeout = null
        $scope.addAlert = (type, message)->
          _alerts = (alert.msg for alert in $scope.alerts)
          return if _alerts.indexOf(message) >= 0
          $scope.alerts.push type: type, msg: message
          $timeout.cancel(clearAlertTimeout) if clearAlertTimeout?

          _closeCountDown = 2000
          if angular.isDefined($scope.closeCountDown)
            _closeCountDown = $scope.closeCountDown
          clearAlertTimeout = $timeout (->
            $scope.clearAlerts()
          ), _closeCountDown

        $scope.closeAlert = (index) ->
          $scope.alerts.splice index, 1

        $scope.clearAlerts = ->
          $scope.alerts = []

        ### hook to notification event ###

        $scope.$on 'notification:info', (e, msg) ->
          $scope.addAlert 'info', msg

        $scope.$on 'notification:success', (e, msg) ->
          $scope.addAlert 'success', msg

        $scope.$on 'notification:error', (e, msg) ->
          $scope.addAlert 'error', msg

        $scope.$on 'notification:clear', ->
          $scope.clearAlerts()
    ]
]