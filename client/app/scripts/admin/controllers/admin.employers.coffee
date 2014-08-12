angular.module('admin').controller 'AdminEmployersCtrl', [
  '$scope'
  'Employer'
  '$route'
  'ServiceEndpoint'
  ($scope, Employer, $route, ServiceEndpoint) ->

    $scope.svcEndpoint = ServiceEndpoint

    @refreshList = ->
      Employer.count($scope.query).then ((count) ->
        $scope.total_results = count
        $scope.total_pages = Math.ceil(count/$scope.query.per_page)
      ), ->
        $scope.notify_error 'Unable to fetch count from server'
      Employer.all($scope.query).then ((employers) ->
        $scope.employers = employers
      ), ->
        $scope.notify_error 'Unable to fetch result from server'

    $scope.clearFilters = ->
      $route.reload()

    init = =>
      $scope.query = {}
      $scope.query.search = ''
      $scope.query.page = 1
      $scope.query.order = 'first_name ASC'
      $scope.query.per_page = 15
      $scope.$watch 'query', (new_value, old_value, scope) =>
        if new_value.page == old_value.page
          scope.query.page = 1
        @refreshList()
      , true
      @refreshList()

    init()
]