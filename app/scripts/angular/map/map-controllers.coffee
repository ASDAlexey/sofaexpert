module.exports = (angular)->
  'use strict'
  controller = angular.module("App.map.map-controllers",[])
  controller.controller "GMapCtrl",[
    "$scope"
    ($scope) ->
      $scope.map = {}
      $scope.options =
        scrollwheel : false
      $scope.coordsUpdates = 0
      $scope.dynamicMoveCtr = 0
      $scope.marker =
        id : 0
  ]