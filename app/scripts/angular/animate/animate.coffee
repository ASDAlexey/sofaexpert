module.exports = (angular,$)->
  'use strict'
  require('./animate-directives.coffee')(angular,$)
  angular.module('App.animate',[
    'App.animate.animate-directives'
  ])