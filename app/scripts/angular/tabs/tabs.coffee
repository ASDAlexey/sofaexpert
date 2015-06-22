module.exports = (angular)->
  'use strict'
  require('./tabs-controllers.coffee')(angular)
  angular.module("App.tabs",[
    "App.tabs.tabs-controllers"
  ])