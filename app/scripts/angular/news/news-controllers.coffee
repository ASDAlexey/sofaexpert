module.exports = (angular)->
  'use strict'
  controller = angular.module("App.news.news-controllers",[])
  controller.controller "NewsCtrl",[
    "$scope"
    ($scope) ->
      @get=(number)->
        href="/sdsdad/"
        history.pushState(null,null,href)
  ]