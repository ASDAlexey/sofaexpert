module.exports = (angular)->
  'use strict'
  require('./youtube-controllers.coffee')(angular)
  angular.module("App.youtube",[
    "App.youtube.youtube-controllers"
  ])