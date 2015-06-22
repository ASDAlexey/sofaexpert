module.exports = (angular)->
  'use strict'
  controller = angular.module("App.slider.slider-controllers",[])
  controller.controller "MoveSliderCtrl",[
    "$scope"
    "$rootScope"
    ($scope,$rootScope) ->
      $scope.currentSlide = 0
      $scope.toSlide = (numberSlide)->
        $scope.currentSlide = numberSlide
        $rootScope.$broadcast('switchMoveSlider',
          currentSlide : $scope.currentSlide
        )
  ]