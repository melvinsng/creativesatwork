angular.module('platform').controller 'FreelancersCtrl', [
  '$scope'
  'Freelancer'
  'job_categories'
  ($scope, Freelancer, job_categories) ->

    $scope.$on 'search:menu', (e, result) ->
      if result.selected == false
        $scope.query.conditions = {}
        $scope.current_job_category = 'All'
      else
        $scope.query.conditions = {job_category_id: result.selected.id}
        $scope.current_job_category = result.selected.name

    $scope.$on 'search:input', (e, search_text) ->
      if search_text? and search_text.length > 0
        $scope.query.search = search_text
      else
        delete $scope.query.search

    @refreshList = ->
      Freelancer.count($scope.query).then ((count) ->
        $scope.total_results = count
        $scope.total_pages = Math.ceil(count/$scope.query.per_page)
      ), ->
        $scope.notify_error 'Unable to fetch count from server'
      Freelancer.all($scope.query).then ((freelancers) ->
        $scope.freelancers = freelancers
      ), ->
        $scope.notify_error 'Unable to fetch result from server'


    init = =>
      $scope.current_job_category = 'All'
      $scope.query = {}
      $scope.query.search = ''
      $scope.query.page = 1
      $scope.query.per_page = 5
      $scope.query.conditions = {}
      $scope.job_categories = job_categories
      $scope.$watch 'query', (new_value, old_value, scope) =>
        if new_value.page == old_value.page
          scope.query.page = 1
        @refreshList()
      , true
      @refreshList()

    init()
]