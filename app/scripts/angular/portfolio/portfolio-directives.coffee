module.exports = (angular)->
  'use strict'
  directive = angular.module('App.portfolio.portfolio-directive',[])
  directive.directive 'popupPortfolio',[
    "$timeout"
    ($timeout)->
      restrict : "E"
      replace : true
      transclude : true
      template : require('./templates/popup-svg.jade')
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          angular.element(element).removeClass('hide')
          overlay = document.querySelector('.portfolio-popup.overlay')
          closeBtn = overlay.querySelector('button.overlay-close')
          tl = new TimelineMax({paused : true})
          choise = angular.element(element).find('.inner-popup form >*').add(angular.element(element).find('.inner-popup >*'))
          tl.staggerFrom(choise,0.8,
            {opacity : 0,scale : 0,y : 80,rotationX : 180,transformOrigin : "0% 50% -50",ease : Back.easeOut},0.1,"+=0")
          openOverlay = ->
            classie.add overlay,'open'
            path.animate {'path' : pathConfig.to},500,mina.easeout
            $timeout(->
              tl.play()
            ,500)
          closeOverlay = ->
            tl.reverse()
            $timeout(->
              path.animate {'path' : pathConfig.from},500,mina.easeout
              classie.remove overlay,'open'
            ,500)
          s = Snap(overlay.querySelector('svg'))
          path = s.select('path')
          pathConfig =
            from : path.attr('d')
            to : overlay.getAttribute('data-path-to')
          scope.$on 'portfolio',(event,data) ->
            scope.data = data.item
            scope.index = data.index
            if data.isOpen
              openOverlay()
            else
              closeOverlay()
  ]
