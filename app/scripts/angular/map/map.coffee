module.exports = (angular)->
  'use strict'
  require('./map-controllers.coffee')(angular)
  angular.module("App.map",[
    "App.map.map-controllers"
  ])