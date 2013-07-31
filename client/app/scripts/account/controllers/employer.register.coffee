angular.module('account').controller 'UserRegisterCtrl', [
  '$scope'
  'Auth'
  'CustomProvider'
  ($scope, Auth, CustomProvider) ->

    $scope.facebookConnect = ->
      CustomProvider.connect('facebook', 'CommonUser')

    $scope.submitForm = ->
      $scope.clear_notifications()
      additional_fields = {
        first_name: $scope.user.first_name,
        last_name: $scope.user.last_name,
        photo_url: '/img/profile.jpg'
      }
      Auth.register('CommonUser', $scope.user.email, 'local', $scope.user.email, $scope.user.password, additional_fields)
]