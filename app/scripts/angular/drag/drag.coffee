module.exports = (angular,$)->
  'use strict'
  require('./drag-directives.coffee')(angular)
  angular.module("App.drag",[
    "App.drag.drag-directives"
  ])