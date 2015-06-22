module.exports = (angular,$)->
  'use strict'
  directive = angular.module('App.drag.drag-directives',[])
  directive.directive 'dragger',[
    "$timeout"
    "$window"
    ($timeout,$window)->
      restrict : "E"
      replace : true
      template : require('./templates/dragger.jade')
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          scope.itemPrice = attrs.item
          currentPosition = {
            current :
              price : 0
            x : 0
            start : 0
            end : 478
            max : attrs.max
          }
          scope.currentPositionPrice = currentPosition
          scope.$apply()
          updatePosition = ()->
            currentPosition.x = this.x
            currentPosition.current.price = currentPosition.x / currentPosition.end * currentPosition.max
            scope.currentPositionPrice = currentPosition
            scope.$apply()
          Draggable.create(".dragger-price",{type : "x",bounds : {minX : currentPosition.start,maxX : currentPosition.end},lockAxis : true,onDrag : updatePosition})
  ]
  directive.directive 'draggerTime',[
    "$timeout"
    "$window"
    ($timeout,$window)->
      restrict : "E"
      replace : true
      template : require('./templates/dragger-time.jade')
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          scope.itemTime = attrs.item
          currentPosition = {
            current :
              time : 0
            x : 0
            start : 0
            end : 478
            max : attrs.max
          }
          scope.currentPositionTime = currentPosition
          scope.$apply()
          updatePosition = ()->
            currentPosition.x = this.x
            currentPosition.current.time = currentPosition.x / currentPosition.end * currentPosition.max
            scope.currentPositionTime = currentPosition
            scope.$apply()
          Draggable.create(".dragger-time",{type : "x",bounds : {minX : currentPosition.start,maxX : currentPosition.end},lockAxis : true,onDrag : updatePosition})
  ]
  directive.directive 'dragScroll',[
    "$timeout"
    "$window"
    ($timeout,$window)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          isDragStart = false
          scope.$on 'about',(event,data) ->
            unless isDragStart
#              angular.element('.info-block .container').removeClass('bounceInLeft')
              scope.currentPerson = data.person
#              angular.element('.info-block .container').addClass('bounceInLeft')
          dragStart = ()->
            isDragStart = true
            angular.element(element).addClass('drag')
          dragEnd = ()->
            $timeout(->
              isDragStart = false
              angular.element(element).removeClass('drag')
            ,0)
          Draggable.create(angular.element(element),
            {type : "scrollLeft",edgeResistance : 0.5,throwProps : true,lockAxis : true,onDragStart : dragStart,onDragEnd : dragEnd})
  ]