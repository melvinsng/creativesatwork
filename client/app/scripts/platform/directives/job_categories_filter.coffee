angular.module('platform').directive 'jobCategoriesFilter', [
  ->
    restrict: 'E'
    templateUrl: 'partials/platform/job_categories_filter.html'
    scope: {}
    controller: [
      '$scope'
      ($scope) ->
        $scope.jobTitles =
          Writing: _.uniq ["Copywriter", "Editor", "Journalist", "Scriptwriter", "Writer"]
          Design: _.uniq ["Art Director", "Audio Designer", "Character Designer", "Creative Director", "Game Designer", "Graphic Designer", "Lighting Designer", "Motion Graphic Designer", "Multimedia Designer", "Product Designer", "Set Designer", "UI/UX Designer", "Wardrode Designer", "Web Designer"]
          Production: _.uniq ["2D Animator", "3D Animator", "3D Artist", "Animator", "Audio Producer", "Camera Assistant", "Cameraman", "Casting Manager", "DI Artist", "Director", "Director and Producer", "Director of Photography", "Grip & Gaffer", "Illustrator", "Lightingman", "Location Manager", "Make Up Artist", "Musician", "Photographer", "Production Assistant", "Production Manager", "Project Manager", "Soundman", "Storyboard Artist", "VFX Artist", "Video Editor", "Video Producer", "Videographer", "Videographer and SteadiCam Operator"]
          Others: _.uniq ["Commentator", "Host", "Marketing", "PR", "Social Media Consultant", "Translator", "Voiceover Artist", "Web Developer"]

        $scope.setJobTitle = ($event) ->
            console.log($event.target.innerHTML)
            $scope.$emit 'search:menu', name: 'job_title', selected: $event.target.innerHTML
    ]
]