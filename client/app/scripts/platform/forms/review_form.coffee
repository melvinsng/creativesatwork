angular.module('platform').directive 'reviewForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {
      type: '@'
      reviewer: '='
      freelancer: '='
      reviewFormOpened: '='
    }
    templateUrl: 'forms/platform/review.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'FormHandler'
      'Review'
      '$q'
      ($scope, $rootScope, $routeParams, FormHandler, Entity, $q) ->

        submitForm = (loggedInUser) =>
          switch $scope.type
            when 'new'
              $scope.form_object.reviewer_id = loggedInUser.id
              promise = Entity.create $scope.form_object, notify_success: false
              success_msg = 'Review has been submitted'
            when 'edit'
              promise = $scope.form_object.put()
              success_msg = 'Your review is updated successfully'
          promise.then ((object)->
            $rootScope.notify_success success_msg
            $scope.closeForm()
            $scope.$emit 'repull_reviews'
          ), ->
            $rootScope.notify_error 'Form has missing or invalid values'

        $scope.submitReview = =>
          $scope.submitted = true
          if $scope.form_object.rating_1 && $scope.form_object.rating_2 && $scope.form_object.rating_3
            if $scope.form.$valid
              $rootScope.clear_notifications()
              loginDeferred = $q.defer()
              loginDeferred.promise.then submitForm
              if $scope.reviewer
                loginDeferred.resolve($scope.reviewer)
              else
                $rootScope.pendingLoginAction = loginDeferred
                alert 'login'
            else
              FormHandler.validate $scope.form.$error, false
          else
            $rootScope.notify_error 'Please leave a rating for this vendor.'

        $scope.closeForm = ->
          $scope.reviewFormOpened = false
          $scope.form_object =
            reviewer_id: ''
            freelancer_id: $scope.freelancer.id
            rating: 0
            content: ''

        init = ->
          FormHandler.formify $scope
          switch $scope.type
            when 'new'
              $scope.form_object =
                reviewer_id: ''
                freelancer_id: $scope.freelancer.id
                rating: 0
                content: ''

            when 'edit'
              Entity.find($routeParams.id).then (obj) ->
                $scope.form_object = obj


        init()
    ]
]