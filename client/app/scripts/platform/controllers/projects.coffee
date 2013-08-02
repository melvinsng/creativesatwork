angular.module('platform').controller 'ProjectsListCtrl', [
  '$scope'
  'projects'
  '$routeParams'
  '$filter'
  ($scope, projects, $routeParams, $filter) ->

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
    $scope.objective = $scope.objectives[$routeParams.objId]
    $scope.projects = $filter('filter')(projects, $scope.objective)

]