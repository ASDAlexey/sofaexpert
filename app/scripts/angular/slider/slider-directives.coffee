module.exports = (angular,$)->
  'use strict'
  directive = angular.module('App.slider.slider-directives',[])
  directive.directive 'moveSlider',[
    "$timeout"
    "MainSlider"
    ($timeout,MainSlider)->
      restrict : "E"
      replace : true
      template : require('./templates/move-slider.jade')
      link : (scope,element,attrs) ->
        MainSlider.get().then (data)->
          scope.listSlider = data
        isDragStart = false
        element.on "mousedown touchstart",->
          angular.element(element[0].querySelector('.move-slider li')).addClass('is-pointer-down')
        element.on "mouseup touchend",->
          angular.element(element[0].querySelector('.move-slider li')).removeClass('is-pointer-down')
        scope.$on "switchMoveSlider",(event,data) ->
          TweenMax.to(element[0].querySelector('.move-slider'),1,{scrollTo : {x : data.currentSlide * 687},ease : Power2.easeOut});
        dragUpdate = ()->
          x = -this.endX
          $timeout(->
            scope.currentSlide = parseInt((x + 100) / 687)
            scope.$apply()
          ,50)
        Draggable.create(element[0].querySelector('.move-slider'),
          {type : "scrollLeft",edgeResistance : 0.5,throwProps : true,lockAxis : true,onDrag : dragUpdate,onDragStart : dragUpdate,onDragEnd : dragUpdate})

  ]