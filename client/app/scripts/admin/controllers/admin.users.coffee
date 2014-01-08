angular.module('admin').controller 'AdminUsersCtrl', [
  '$scope'
  'Freelancer'
  'job_categories'
  '$route'
  'ServiceEndpoint'
  ($scope, Freelancer, job_categories, $route, ServiceEndpoint) ->

    $scope.svcEndpoint = ServiceEndpoint

    $scope.$watch 'query.conditions.job_title', (new_val) ->
      angular.forEach $scope.jobTitles, (cat_value, cat_key) ->
        angular.forEach cat_value, (value) ->
          if angular.equals(new_val, value)
            $scope.current_job_category = cat_key

    $scope.$on 'search:menu', (e, result) ->
      if result.selected == false
        delete $scope.query.conditions.job_title
        $scope.current_job_title = 'All'
      else
        $scope.query.conditions.job_title = result.selected
        $scope.current_job_title = result.selected

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

    $scope.clearFilters = ->
      $route.reload()

    init = =>
      $scope.jobTitles =
        Writing: _.uniq ["Copywriter", "Editor", "Journalist", "Scriptwriter", "Writer"]
        Design: _.uniq ["Art Director", "Audio Designer", "Character Designer", "Creative Director", "Game Designer", "Graphic Designer", "Lighting Designer", "Motion Graphic Designer", "Multimedia Designer", "Product Designer", "Set Designer", "UI/UX Designer", "Wardrode Designer", "Web Designer"]
        Production: _.uniq ["2D Animator", "3D Animator", "3D Artist", "Animator", "Audio Producer", "Camera Assistant", "Cameraman", "Casting Manager", "DI Artist", "Director", "Director and Producer", "Director of Photography", "Grip & Gaffer", "Illustrator", "Lightingman", "Location Manager", "Make Up Artist", "Musician", "Photographer", "Production Assistant", "Production Manager", "Project Manager", "Soundman", "Storyboard Artist", "VFX Artist", "Video Editor", "Video Producer", "Videographer", "Videographer and SteadiCam Operator"]
        Others: _.uniq ["Commentator", "Host", "Marketing", "PR", "Social Media Consultant", "Translator", "Voiceover Artist", "Web Developer"]

      $scope.current_job_title = 'All'
      $scope.current_job_category = 'All'
      $scope.query = {}
      $scope.query.search = ''
      $scope.query.page = 1
      $scope.query.per_page = 15
      $scope.query.conditions = {profile_incomplete: false}
      $scope.job_categories = job_categories
      $scope.$watch 'query', (new_value, old_value, scope) =>
        if new_value.page == old_value.page
          scope.query.page = 1
        @refreshList()
      , true
      @refreshList()

    init()
]