module.exports = (angular)->
  'use strict'
  require('./form-controllers.coffee')(angular)
  require('./form-directives.coffee')(angular)
  require('./form-filters.coffee')(angular)
  require('./form-services.coffee')(angular)
  angular.module('App.form',[
    "App.form.form-controllers"
    "App.form.form-filters"
    "App.form.form-directives"
    "App.form.form-services"
  ])