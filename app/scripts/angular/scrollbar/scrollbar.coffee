module.exports = (angular)->
  'use strict'
  require('./scrollbar-controllers.coffee')(angular)
  angular.module("App.scrollbar",[
    "App.scrollbar.scrollbar-controllers"
  ])