module.exports = (angular)->
  'use strict'
  require('./aside-controllers.coffee')(angular)
  angular.module("App.aside",[
    "App.aside.aside-controllers"
  ])