angular.module('pages').controller 'HomeCtrl', [
  '$scope'
  ($scope) ->

    switch $scope.user_type
      when 'freelancer'
        alert 'freelancer'
        #$scope.redirect_to ''
      when 'employer'
        alert 'employer'
        #$scope.redirect_to ''

]