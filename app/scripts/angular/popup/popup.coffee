module.exports = (angular)->
  'use strict'
  require('./popup-controllers.coffee')(angular)
  require('./popup-directives.coffee')(angular)
  require('./popup-filters.coffee')(angular)
  require('./popup-services.coffee')(angular)
  angular.module('App.popup',[
    "App.popup.popup-controllers"
    "App.popup.popup-filter"
    "App.popup.popup-services"
    'App.popup.popup-directive'
#  'App.popup.popup-templates'
  ])