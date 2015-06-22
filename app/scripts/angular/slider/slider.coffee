module.exports = (angular)->
  'use strict'
  require('./slider-controllers.coffee')(angular)
  require('./slider-directives.coffee')(angular)
  require('./slider-services.coffee')(angular)
  angular.module("App.slider",[
    "App.slider.slider-controllers"
    "App.slider.slider-directives"
    "App.slider.slider-services"
  ])