module.exports = (angular,$)->
  'use strict'
  require('./preloader-directives.coffee')(angular,$)
  angular.module("App.preloader",[
    "App.preloader.preloader-directives"
  ])