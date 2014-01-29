angular.module('admin').directive 'adminLoginForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {}
    templateUrl: 'forms/admin/login.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'Auth'
      ($scope, $rootScope, $routeParams, Auth) ->


        init = ->
          if $rootScope.authenticated
            $rootScope.redirect_to 'home', info: 'You have already logged in'

          $scope.hasError = (input) ->
            !input.$valid && (input.$dirty || $scope.submitted)

          $scope.login = ->
            $scope.submitted = true
            if $scope.form.$valid
              $rootScope.clear_notifications()
              Auth.authenticate('Admin', $scope.user.email, 'local', $scope.user.password)

          $scope.submitted = false

        if $rootScope.authenticated
          $rootScope.redirect_to 'home', info: 'You have already logged in'
        $rootScope.$on 'user_ready', init


    ]
]