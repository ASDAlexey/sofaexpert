module.exports = (angular)->
  'use strict'
  controller = angular.module("App.scrollbar.scrollbar-controllers",[])
  BaseController = ($scope,$http) ->
    $scope.items = []
    $http.get('./json/list-scrollbar.json')
    .then (res)->
      $scope.items = res.data
    config = {}
    $scope.scrollbar = (direction,autoResize,show) ->
      config.direction = direction
      config.autoResize = autoResize
      config.scrollbar =
        show : !!show
      config.scrollbar =
        width : 6
        hoverWidth : 8
        color : '#fff'
        show : true
      config.scrollbarContainer =
        width : 6
        color : '#000'
      config
  controller.controller 'Manual',[
    "$scope"
    "mbScrollbar"
    "$http"
    ($scope,mbScrollbar,$http) ->
      new BaseController($scope,$http)
      mbScrollbar.recalculate $scope
  ]
  controller.controller 'AboutCtrl',[
    "$scope"
    "$http"
    "$rootScope"
    ($scope,$http,$rootScope) ->
      $http.get('./json/about.json')
      .then (res)->
        $scope.people = res.data
        $scope.currentPerson=$scope.people[0]
      $scope.mouseUp=(person,isMobile)->
        if isMobile is 'desktop'
          $rootScope.$broadcast('about',
            person : person
          )
        if isMobile is 'mobile'
          if angular.element('.ua-mobile').length
            $rootScope.$broadcast('about',
              person : person
            )
  ]