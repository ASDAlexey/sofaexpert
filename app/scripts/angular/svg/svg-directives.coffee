module.exports = (angular)->
  'use strict'
  directive = angular.module('App.svg.svg-directives',[])
  directive.directive 'progressCircle',[
    "$timeout"
    "$window"
    ($timeout,$window)->
      restrict : "E"
      replace : true
      template : require('./templates/progress-circle.jade')
      link : (scope,element,attrs) ->
        TweenMax.set(element[0].querySelector('.circle'),{drawSVG : '0% 0%'})
        scope.$on 'preloader:progress',(event,data) ->
#          TweenMax.fromTo(element[0].querySelector('.circle'),.7,{drawSVG : "0%"},{drawSVG : "#{data.persent}%"})
          TweenMax.to(element[0].querySelector('.circle'),.7,{drawSVG : "#{data.persent}%"})
  ]