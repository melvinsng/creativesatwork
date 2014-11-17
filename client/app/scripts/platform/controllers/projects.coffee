angular.module('platform').controller 'ProjectsCtrl', [
  '$scope'
  'Project'
  'job_categories'
  '$route'
  '$rootScope'
  ($scope, Project, job_categories, $route, $rootScope) ->

    $scope.$on 'search:menu', (e, result) ->
      switch result.name
        when 'job_categories'
          if result.selected == false
            delete $rootScope.projects_query.conditions.job_category_id
            $scope.current_job_category = 'All'
          else
            $rootScope.projects_query.conditions.job_category_id = result.selected.id
            $scope.current_job_category = result.selected.name
        when 'budget_range'
          if result.selected == false
            delete $rootScope.projects_query.conditions.budget_range
          else
            $rootScope.projects_query.conditions.budget_range = result.selected

    $scope.$on 'search:input', (e, search_text) ->
      if search_text? and search_text.length > 0
        $rootScope.projects_query.search = search_text
      else
        delete $rootScope.projects_query.search

    @refreshList = ->
      Project.count($rootScope.projects_query).then ((count) ->
        $scope.total_results = count
        $scope.total_pages = Math.ceil(count/$rootScope.projects_query.per_page)
      ), ->
        $scope.notify_error 'Unable to fetch count from server'
      Project.all($rootScope.projects_query).then ((projects) ->
        $rootScope.projects = projects
      ), ->
        $scope.notify_error 'Unable to fetch result from server'

    $scope.clearFilters = ->
      $rootScope.projects_query = {}
      $rootScope.projects_query.search = ''
      $rootScope.projects_query.page = 1
      $rootScope.projects_query.per_page = 5
      $rootScope.projects_query.conditions =
        project_status: 'project_pending'
      $route.reload()

    init = =>
      $scope.current_job_category = 'All'
      $scope.budget_ranges = [
        'S$0 - S$500'
        'S$500 - S$1000'
        'S$1000 - S$2000'
        'S$2000 - S$3000'
        'S$3000 - S$5000'
        'S$5000 - S$10000'
      ]
      $scope.job_categories = job_categories

      if not $rootScope.projects_query
        $rootScope.projects_query = {}
        $rootScope.projects_query.search = ''
        $rootScope.projects_query.page = 1
        $rootScope.projects_query.per_page = 5
        $rootScope.projects_query.conditions =
          project_status: 'project_pending'
        $rootScope.$watch 'projects_query', (new_value, old_value, scope) =>
          if new_value.page == old_value.page
            $rootScope.projects_query.page = 1
          @refreshList()
        , true
      @refreshList()

    init()
]