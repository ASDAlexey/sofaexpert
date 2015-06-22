module.exports = (angular)->
  'use strict'
  controller = angular.module("App.aside.aside-controllers",[])
  controller.controller "AsideCrtl",[
    "$scope"
    ($scope) ->
      @switchList = (number)->
        @currentList = number
  ]