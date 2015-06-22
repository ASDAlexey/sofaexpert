module.exports = (angular,$)->
  'use strict'
  directive = angular.module('App.photobox.photobox-directives',[])
  directive.directive 'photobox',[
    "$timeout"
    ($timeout) ->
      restrict : "A"
      link : (scope,element,attr) ->
        angular.element(document).ready ->
          $timeout(->
            $(element).photobox('a')
          ,0)
  ]
