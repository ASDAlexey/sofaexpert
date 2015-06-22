module.exports = (angular)->
  'use strict'
  directive = angular.module('App.animate.animate-directives',[])
  directive.directive 'rotate',[
    "$timeout"
    ($timeout)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          tl = new TimelineMax({repeat : -1});
          tl.to($(element).find('span'),2,{rotation : 360,ease : Linear.easeNone})
          tl.pause()
          $(element).on 'mouseenter',->
            tl.play()
          $(element).on 'mouseleave',->
            tl.pause()
  ]
  directive.directive 'flip3d',[
    "$timeout"
    ($timeout)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          CSSPlugin.defaultTransformPerspective = 1000
          TweenMax.set(element,{rotationY : -90,transformOrigin : "0 0 0"})
          tl = new TimelineMax({paused : true})
          tl.to(element,.7,{rotationY : 0,transformOrigin : "0 0 0",ease : Back.easeOut})
          scope.$on 'preloader:loaded',(event,data) ->
            $timeout(->
              tl.play()
            ,500)
  ]
  directive.directive 'animateClass',[
    "$timeout"
    ($timeout)->
      restrict : "A"
      scope :
        "animateClass" : "@"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          scope.$on 'preloader:loaded',(event,data) ->
            $timeout(->
              element.removeClass('opacity0')
              element.addClass(scope.animateClass)
            ,500)
  ]
  directive.directive 'flip3dreverse',[
    "$timeout"
    ($timeout)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          CSSPlugin.defaultTransformPerspective = 1000
          TweenMax.set(element,{rotationY : -30,transformOrigin : "100% 0 0"})
          tl = new TimelineMax({paused : true})
          tl.to(element,.7,{rotationY : 0,transformOrigin : "100% 0 0",ease : Back.easeOut})
          scope.$on 'preloader:loaded',(event,data) ->
            $timeout(->
              tl.play()
            ,500)
  ]
  directive.directive 'fadein3d',[
    "$timeout"
    "$window"
    ($timeout,$window)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          tl = new TimelineMax({paused : true})
          choisen = element[0].childNodes
          if choisen.length > 1
            tl.staggerFrom(choisen,1.5,{opacity : 0,scale : 0,y : 80,rotationX : 180,transformOrigin : "0% 50% -50",ease : Back.easeOut},0.2,"+=0")
          else
            tl.from(choisen,1.5,{opacity : 0,scale : 0,y : 80,rotationX : 180,transformOrigin : "0% 50% -50",ease : Back.easeOut})
          scope.$on 'preloader:loaded',(event,data) ->
            $timeout(->
              tl.play()
            ,500)
  ]