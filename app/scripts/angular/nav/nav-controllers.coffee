module.exports = (angular)->
  'use strict'
  controller = angular.module("App.nav.nav-controllers",[])
  controller.controller "NavCrtl",[
    "$scope"
    ($scope) ->
      @servises=[false,false,false,false]
#      @show
  ]