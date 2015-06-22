module.exports = (angular)->
  'use strict'
  require('./portfolio-controllers.coffee')(angular)
  require('./portfolio-directives.coffee')(angular)
  require('./portfolio-filters.coffee')(angular)
  require('./portfolio-services.coffee')(angular)
  angular.module('App.portfolio',[
    "App.portfolio.portfolio-controllers"
    "App.portfolio.portfolio-filter"
    "App.portfolio.portfolio-services"
    'App.portfolio.portfolio-directive'
  ])