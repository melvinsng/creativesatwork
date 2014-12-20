angular.module('platform').controller 'FreelancersShowCtrl', [
  '$scope'
  'freelancer'
  'Project'
  'Review'
  'CommonApi'
  ($scope, freelancer, Project, Review, CommonApi) ->
    $scope.freelancer = freelancer

    $scope.offerProject = ->
      Project.add_offer($scope.offering_project_id, freelancer.id).then (res)->
        console.log res
        $scope.notify_success 'Project offered'
      , (response) ->
        console.log response
        console.log 'failed 102'

    $scope.submitQuestionToAdmin = ->
      if $scope.question_from_employer
        CommonApi.submit_question_about_freelancer_to_admin($scope.question_from_employer, freelancer.id, $scope.current_user.id).then ->
          $scope.notify_success 'Question submitted successfully.'
        , (res) ->
          console.log res
          console.log 'failed 103'
      else
        $scope.notify_info 'Please fill in the form..'

    ### REVIEWS ###
    $scope.reviewFormOpened = false
    $scope.reviews_query =
      order: 'created_at DESC'
      page: 1
      per_page: 3
      conditions:
        freelancer_id: freelancer.id
        is_approved: true

    $scope.all_reviews_count = Review.count()

    $scope.populateReviews = ->
      Review.count($scope.reviews_query).then ((count) ->
        $scope.total_review_results = count
        $scope.total_review_pages = Math.ceil(count/$scope.reviews_query.per_page)
      ), ->
        $scope.notify_error 'Unable to fetch count from server'
      Review.all($scope.reviews_query).then ((reviews) ->
        $scope.reviews = reviews
      ), ->
        $scope.notify_error 'Unable to fetch result from server'

    $scope.$on 'repull_reviews', ->
      $scope.populateReviews()

    $scope.$watch 'reviews_query', (new_value, old_value, scope) ->
      if new_value.page == old_value.page
        scope.reviews_query.page = 1
      $scope.populateReviews()
    , true

]