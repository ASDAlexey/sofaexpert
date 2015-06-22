module.exports = (angular,$)->
  'use strict'
  require('./photobox-directives.coffee')(angular,$)
  angular.module('App.photobox',[
    'App.photobox.photobox-directives'
  ])