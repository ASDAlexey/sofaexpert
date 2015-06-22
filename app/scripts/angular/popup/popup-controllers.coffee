module.exports = (angular)->
  'use strict'
  controller = angular.module("App.popup.popup-controllers",[])
  controller.controller "PopupCtrl",[
    "$rootScope"
    ($rootScope) ->
      @open = (name,data = '',index)->
        if name is 'portfolioDetails'
          if _.isString(data)
            data = angular.fromJson(data)
          $rootScope.$broadcast('portfolioDetails',
            name : name
            data : data
            index : index
          )
        else
          $rootScope.$broadcast('popup',
            name : name
          )
      @prev = (name,data = '',index)->
        unless index is 0
          @open(name,$rootScope.portfolio[index - 1],index - 1)
      @next = (name,data = '',index)->
        unless index is $rootScope.portfolio.length - 1
          @open(name,$rootScope.portfolio[index + 1],index + 1)
      @prevMain = (data = '',index)->
          $rootScope.$broadcast('portfolio',
            item : $rootScope.portfolioMain[index - 1]
            isOpen : true
            index : index - 1
          )
      @nextMain = (data = '',index)->
        unless index is $rootScope.portfolioMain.length - 1
          $rootScope.$broadcast('portfolio',
            item : $rootScope.portfolioMain[index + 1]
            isOpen : true
            index : index + 1
          )
  ]