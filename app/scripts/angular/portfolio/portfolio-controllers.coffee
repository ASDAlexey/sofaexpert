module.exports = (angular)->
  'use strict'
  controller = angular.module("App.portfolio.portfolio-controllers",[])
  controller.controller "PortfolioCtrl",[
    "$scope"
    "$rootScope"
    "$http"
    ($scope,$rootScope,$http) ->
      #youtube
      $scope.playerVars = {
        controls : 0
        showinfo : 0
        autoplay : 0
      }
      $scope.openPortfolio = (item,index)->
        if _.isString(item)
          item = angular.fromJson(item)
        $rootScope.$broadcast('portfolio',
          item : item
          isOpen : true
          index:index
        )
      $scope.closePortfolio = (player)->
        player.pauseVideo()
        $rootScope.$broadcast('portfolio',
          isOpen : false
        )
      player = ''
      $scope.isFullScreen = false
      $scope.toFullScreen = (data)->
        player = data
        player.playVideo()
        elem = document.querySelector('.list-portfolio-video .video iframe')
        if elem.requestFullscreen
          elem.requestFullscreen()
        else if elem.msRequestFullscreen
          elem.msRequestFullscreen()
        else if elem.mozRequestFullScreen
          elem.mozRequestFullScreen()
        else if elem.webkitRequestFullscreen
          elem.webkitRequestFullscreen()
      FShandler = (event)->
        if $scope.isFullScreen
          $scope.isFullScreen = false
          player.pauseVideo()
        else
          $scope.isFullScreen = true
      document.addEventListener("fullscreenchange",FShandler)
      document.addEventListener("webkitfullscreenchange",FShandler)
      document.addEventListener("mozfullscreenchange",FShandler)
      document.addEventListener("MSFullscreenChange",FShandler)

      urlStart = "./json/portfolio.json"
      $http(
        url : urlStart
        method : "GET"
      ).then (res) ->
        $rootScope.portfolioMain = _.union($rootScope.portfolioMain,res.data)
        $scope.defaultMainLenght = angular.copy($rootScope.portfolioMain).length
      url = "./json/add-portfolio.json"
      $http(
        url : url
        method : "GET"
      ).then (res) ->
        $rootScope.portfolioMain = _.union($rootScope.portfolioMain,res.data)
      #Подгрузка данных в Портфолио
      $scope.currentAdd = 0
      $scope.addPortfolio = ()->
        $scope.currentAdd++
  ]
  controller.controller "PortfolioDetailsCtrl",[
    "$scope"
    "$rootScope"
    "$http"
    ($scope,$rootScope,$http) ->
#youtube
      $scope.playerVars = {
        controls : 0
        showinfo : 0
        autoplay : 0
      }
      urlStart = "./json/portfolio.json"
      $http(
        url : urlStart
        method : "GET"
      ).then (res) ->
        $rootScope.portfolio = _.union($rootScope.portfolio,res.data)
        $scope.defaultLenght = angular.copy($rootScope.portfolio).length
      url = "./json/add-portfolio.json"
      $http(
        url : url
        method : "GET"
      ).then (res) ->
        $rootScope.portfolio = _.union($scope.portfolio,res.data)
      $scope.currentAdd = 0
      $scope.addPortfolio = ()->
        $scope.currentAdd++
  ]