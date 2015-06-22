module.exports = (angular)->
  'use strict'
  require('./nav-controllers.coffee')(angular)
  angular.module("App.nav",[
    "App.nav.nav-controllers"
  ])