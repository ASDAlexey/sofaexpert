module.exports = (angular)->
  'use strict'
  require('./news-controllers.coffee')(angular)
  angular.module("App.news",[
    "App.news.news-controllers"
  ])