module.exports = (angular,$)->
  'use strict'
  require('./svg-directives.coffee')(angular,$)
  angular.module("App.svg",[
    "App.svg.svg-directives"
  ])