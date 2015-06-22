module.exports = (angular)->
  'use strict'
  directive = angular.module('App.popup.popup-directive',[])
  directive.directive 'popup',[
    "$timeout"
    "$window"
    ($timeout,$window) ->
      restrict : "E"
      replace : true
      template : """
          <svg version="1.1" baseProfile="tiny" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0" y="0" width="1920" height="1440" ng-viewBox="0 0 1920 1440" xml:space="preserve"></svg>
        """
      link : (scope,element,attr) ->
        angular.element(document).ready ->
          scope.ww = $(window).width()
          scope.wh = $(window).height()
          angular.element($window).bind 'resize',->
            scope.ww = $(window).width()
            scope.wh = $(window).height()
          class Popup
            constructor : (data)->
              @canvas = data.canvas
              @canvas = Snap(@canvas)
              property =
                cx : 975
                cy : 745
                r : 75
              @drawSvgCircle(property)
              @tmPopup = new TimelineLite()
              @tmPopup.staggerFrom(
                $('.popup-content-wrap.search .inner>*'),0.8,
                {opacity : 0,scale : 0,y : 80,rotationX : 180,transformOrigin : "0% 50% -50",ease : Back.easeOut},0.1,"+=0"
              )
              @tmPopup.pause()
              @events(property)
            path : ''
            tmPopup : ''
            pathCircle : ''
            drawSvgCircle : (property)->
              @pathCircle = @canvas.path(@circle(property))
              @pathCircle.attr(
                fill : "#fff"
                "fill-opacity" : 1
              )
              numberIndex = 0
              animate = (number)=>
                @pathCircle.animate {
                  path : @circle(
                    cx : 975
                    cy : 745
                    r : number
                  )
                  fillOpacity : 1
                },2000,mina.easeinout
              animate(1)
            tl : ''
            circle : (property) ->
              'm ' + property.cx + ' ' + property.cy + ' m -' + property.r + ', 0 a ' + property.r + ',' + property.r + ' 0 1,0 ' + property.r * 2 + ',0 a ' + property.r + ',' + property.r + ' 0 1,0 -' + property.r * 2 + ',0'
            rectangle : (property)->
              "m #{property.x},#{property.y} L #{property.x},#{property.width} L #{property.height},#{property.width} L #{property.height},#{property.x} z"
            events : (property)->
              $(document).on "click",".show-popup",(e)=>
                scope.popup = $(e.currentTarget).data('popup')
                scope.$apply()
                $(".popup-content-wrap").css('visibility','visible')
                @pathCircle.animate {
                  path : @circle(
                    cx : 975
                    cy : 745
                    r : 3000
                  )
                  fillOpacity : 1
                },1500,mina.easeinout
                $timeout(=>
                  @tmPopup.play()
                ,1000)
                $(document).on "click",".close-popup",=>
                  @tmPopup.reverse()
                  $timeout(=>
                    @pathCircle.animate {
                      path : @circle(
                        cx : 975
                        cy : 745
                        r : 1
                      )
                      fillOpacity : 1
                    },1500,mina.easeinout,=>
                      $(".popup-content-wrap").css('visibility','hidden')
                  ,1500)
          new Popup(
            canvas : $(element).get(0)
          )
  ]
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
  directive.directive 'popupSvg',[
    "$timeout"
    "$document"
    "$rootScope"
    ($timeout,$document,$rootScope)->
      restrict : "E"
      replace : true
      transclude : true
      template : require('./templates/popup-svg.jade')
      link : (scope,element,attrs) ->
        scope.fill = "rgba(0,0,0,.7)"
        angular.element(document).ready ->
          angular.element(element).removeClass('hide')
          tl = new TimelineMax({paused : true})
          choise = angular.element(element).find('.inner-popup form >*').add(angular.element(element).find('.inner-popup >*'))
          tl.staggerFrom(choise,0.8,
            {opacity : 0,scale : 0,y : 80,rotationX : 180,transformOrigin : "0% 50% -50",ease : Back.easeOut},0.1,"+=0")
          scope.$on 'popup',(event,data) ->
            name = data.name
            overlay = $document[0].querySelector(".#{name}.overlay")
            closeBtn = overlay.querySelector('.overlay-close')
            openOverlay = ->
              classie.add overlay,'open'
              path.animate {'path' : pathConfig.to},500,mina.easeout
              $timeout(->
                tl.play()
              ,500)
            closeOverlay = ->
              if name is 'video-popup'
                _.findWhere($rootScope.youtubeVideo,{"id" : "JFm36q4JF9k"}).player.pauseVideo()
              if name is 'recall'
                angular.element(overlay).removeClass('black')
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
            openOverlay()
            closeBtn.addEventListener 'click',closeOverlay
  ]
  directive.directive 'portfolioDetails',[
    "$timeout"
    "$document"
    "$rootScope"
    ($timeout,$document,$rootScope)->
      restrict : "E"
      replace : true
      transclude : true
      template : require('./templates/popup-portfolio-details.jade')
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          angular.element(element).removeClass('hide')
          scope.fill = "#fff"
          tl = new TimelineMax({paused : true})
          choise = angular.element(element).find('.inner-popup form >*').add(angular.element(element).find('.inner-popup >*'))
          tl.staggerFrom(choise,0.8,
            {opacity : 0,scale : 0,y : 80,rotationX : 180,transformOrigin : "0% 50% -50",ease : Back.easeOut},0.1,"+=0")
          scope.$on 'portfolioDetails',(event,data) ->
            name = data.name
            scope.data = data.data
            scope.index = data.index
            overlay = $document[0].querySelector(".#{name}.overlay")
            closeBtn = overlay.querySelector('.overlay-close')
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
            openOverlay()
            closeBtn.addEventListener 'click',closeOverlay
  ]