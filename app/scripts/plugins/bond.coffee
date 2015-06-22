module.exports = ($)->
  $.fn.extend bond: (settings) ->
    get3dCoord = (type, node) ->
  # Reads X or Y from the transform property
      style = undefined
      if typeof document.body.style.transform != 'undefined'
        style = node[0].style.transform.toString()
      else if typeof document.body.style.webkitTransform != 'undefined'
        style = node[0].style.webkitTransform.toString()
      else if typeof document.body.style.mozTransform != 'undefined'
        style = node[0].style.mozTransform.toString()
      else if typeof document.body.style.oTransform != 'undefined'
        style = node[0].style.oTransform.toString()
      else
        console.log 'Your browser does not support css transforms'
        return 0
      parseInt(style.substring(style.indexOf('(') + 1).split(',')[type]) or 0

    $.extend $.easing, easeOutExpo: (x, t, b, c, d) ->
      if t == d then b + c else c * (-2 ** (-10 * t / d) + 1) + b
    defaults =
      orientation: 'horz'
      restArea: 6
      maxSpeed: 7
      startPos: 0
      desktopMode: 'move'
      mobileMode: 'touchCss'
      wrapperSelector: '.bond-wrapper'
      boxSelector: '.bond-box'
      slideSelector: '.bond-slide'
      easingCss: 'cubic-bezier(0,1,1,1)'
      easingMargin: 'easeOutExpo'
      timeBounce: '0.01s'
      timeScroll: '3s'
      timeBack: '0.5s'
      maxVelocity: 15
      bounce: 5
      slideClickCallback: (N, delta) ->
    if !settings
      settings = defaults
    for option of defaults
      `option = option`
      if !(option of settings) or settings[option] == undefined
        settings[option] = defaults[option]
    isMobile = false
    isiPad = navigator.userAgent.match(/iPad/i) != null
    isiPhone = navigator.userAgent.match(/iPhone/i) != null
    isiPod = navigator.userAgent.match(/iPod/i) != null
    if isiPad or isiPhone or isiPod
      isMobile = true
    @each ->
      mode = undefined
      # move, css, margin
      scrollspeed = 0
      movestate = ''
      lefttime = undefined
      toptime = undefined
      # Timers for back moving
      righttime = undefined
      bottomtime = undefined
      # Timers for forward moving
      touchstartPos = undefined
      touchtime = undefined
      delta = undefined
      velo = undefined
      bond = $(this)
      wrapper = bond.children(settings.wrapperSelector)
      box = wrapper.children(settings.boxSelector)
      bondtall = 0
      actualtall = 0

      moveleft = ->
        movestate = 'left'
        left = parseInt(wrapper.css('left'))
        if left > bondtall - actualtall
          wrapper.css 'left', left - scrollspeed + 'px'
        lefttime = setTimeout(moveleft, 10)
        return

      moveright = ->
        movestate = 'right'
        left = parseInt(wrapper.css('left'))
        if left < 0
          wrapper.css 'left', left + scrollspeed + 'px'
        righttime = setTimeout(moveright, 10)
        return

      movetop = ->
        movestate = 'top'
        top = parseInt(wrapper.css('top'))
        if top > bondtall - actualtall
          wrapper.css 'top', top - scrollspeed + 'px'
        toptime = setTimeout(movetop, 10)
        return

      movebottom = ->
        movestate = 'bottom'
        top = parseInt(wrapper.css('top'))
        if top < 0
          wrapper.css 'top', top + scrollspeed + 'px'
        bottomtime = setTimeout(movebottom, 10)
        return

      motionengine = (e) ->
        if settings.orientation == 'horz'
          motionengineH e
        else if settings.orientation == 'vert'
          motionengineV e
        return

      motionengineH = (e) ->
        offset = bond.offset().left
        docx = $(document).scrollLeft()
        curpos = (if window.event then event.clientX else if e.clientX then e.clientX else '') - (offset - docx)
        leftbound = (bondtall - (settings.restArea)) / 2
        rightbound = (bondtall + settings.restArea) / 2
        if curpos > rightbound
          scrollspeed = (curpos - rightbound) / leftbound * settings.maxSpeed
          clearTimeout righttime
          if movestate != 'left'
            moveleft()
        else if curpos < leftbound
          scrollspeed = (leftbound - curpos) / leftbound * settings.maxSpeed
          clearTimeout lefttime
          if movestate != 'right'
            moveright()
        else
          scrollspeed = 0
        return

      motionengineV = (e) ->
        offset = bond.offset().top
        docy = $(document).scrollTop()
        curpos = (if window.event then event.clientY else if e.clientY then e.clientY else '') - (offset - docy)
        topbound = (bondtall - (settings.restArea)) / 2
        bottombound = (bondtall + settings.restArea) / 2
        if curpos > bottombound
          scrollspeed = (curpos - bottombound) / topbound * settings.maxSpeed
          clearTimeout bottomtime
          if movestate != 'top'
            movetop()
        else if curpos < topbound
          scrollspeed = (topbound - curpos) / topbound * settings.maxSpeed
          clearTimeout toptime
          if movestate != 'bottom'
            movebottom()
        else
          scrollspeed = 0
        return

      stopmotion = (e) ->
        if settings.orientation == 'horz'
          clearTimeout lefttime
          clearTimeout righttime
        else if settings.orientation == 'vert'
          clearTimeout toptime
          clearTimeout bottomtime
        movestate = ''
        return

      touchstart = (e) ->
        if !isMobile and e.button == 2
          return false
        moveEvent = if e.originalEvent and e.originalEvent.touches then e.originalEvent.touches[0] else e
        e.stopPropagation()
        delta = 0
        velo = 0
        switch mode
          when 'css'
            wrapper.css
              '-webkit-transition-duration': '0s'
              '-moz-transition-duration': '0s'
              '-o-transition-duration': '0s'
              'transition-duration': '0s'
            if settings.orientation == 'horz'
              touchstartPos = moveEvent.pageX - get3dCoord(0, wrapper)
            else if settings.orientation == 'vert'
              touchstartPos = moveEvent.pageY - get3dCoord(1, wrapper)
          when 'margin'
            wrapper.stop()
            if settings.orientation == 'horz'
              touchstartPos = moveEvent.pageX - parseFloat(wrapper.css('left'))
            else if settings.orientation == 'vert'
              touchstartPos = moveEvent.pageY - parseFloat(wrapper.css('top'))
        bond.bind 'mousemove touchmove', (e) ->
          touchmove e
          return
        $(document).bind 'mouseup touchend', (e) ->
          touchend e
          return
        false

      touchmove = (e) ->
        moveEvent = if e.originalEvent and e.originalEvent.touches then e.originalEvent.touches[0] else e
        e.preventDefault()
        e.stopPropagation()
        if settings.orientation == 'horz'
          page = moveEvent.pageX
        else if settings.orientation == 'vert'
          page = moveEvent.pageY
        velo = delta - (page - touchstartPos)
        delta = page - touchstartPos
        X = delta
        if delta > 0
          if delta >= maxOut
            X = Math.sqrt(delta - maxOut) * 10
          else
            X = 0
        else if delta < -actualtall + bondtall
          X = -actualtall + bondtall - (Math.sqrt(Math.abs(Math.abs(delta + actualtall - bondtall))) * 10)
        switch mode
          when 'css'
            if settings.orientation == 'horz'
              wrapper.css
                '-webkit-transform': 'translate3d(' + X + 'px, 0px, 0px)'
                '-moz-transform': 'translate3d(' + X + 'px, 0px, 0px)'
                '-o-transform': 'translate3d(' + X + 'px, 0px, 0px)'
                'transform': 'translate3d(' + X + 'px, 0px, 0px)'
            else if settings.orientation == 'vert'
              wrapper.css
                '-webkit-transform': 'translate3d(0px, ' + X + 'px, 0px)'
                '-moz-transform': 'translate3d(0px, ' + X + 'px, 0px)'
                '-o-transform': 'translate3d(0px, ' + X + 'px, 0px)'
                'transform': 'translate3d(0px, ' + X + 'px, 0px)'
          when 'margin'
            if settings.orientation == 'horz'
              wrapper.css 'left', X
            else if settings.orientation == 'vert'
              wrapper.css 'top', X
        false

      touchend = (e) ->
        if Math.abs(velo) > settings.maxVelocity
          switch mode
            when 'css'
              if settings.orientation == 'horz'
                coord = get3dCoord(0, wrapper)
              else if settings.orientation == 'vert'
                coord = get3dCoord(1, wrapper)
            when 'margin'
              if settings.orientation == 'horz'
                coord = parseFloat(wrapper.css('left'))
              else if settings.orientation == 'vert'
                coord = parseFloat(wrapper.css('top'))
          out = Math.floor(coord - (Math.sqrt(Math.abs(velo)) * 100 * velo / Math.abs(velo)))
          time = settings.timeScroll
          if out > 0
            out = maxOut * settings.bounce
            time = settings.timeBounce
          else if out < -actualtall + bondtall
            out = -actualtall + bondtall - (maxOut * settings.bounce)
            time = settings.timeBounce
          else
            time = settings.timeScroll
          switch mode
            when 'css'
              wrapper.css
                '-webkit-transition-timing-function': settings.easingCss
                '-webkit-transition-duration': time
                '-moz-transition-timing-function': settings.easingCss
                '-moz-transition-duration': time
                '-o-transition-timing-function': settings.easingCss
                '-o-transition-duration': time
                'transition-timing-function': settings.easingCss
                'transition-duration': time
              if settings.orientation == 'horz'
                wrapper.css
                  '-webkit-transform': 'translate3d(' + out + 'px, 0px, 0px)'
                  '-moz-transform': 'translate3d(' + out + 'px, 0px, 0px)'
                  '-o-transform': 'translate3d(' + out + 'px, 0px, 0px)'
                  'transform': 'translate3d(' + out + 'px, 0px, 0px)'
              else if settings.orientation == 'vert'
                wrapper.css
                  '-webkit-transform': 'translate3d(0px, ' + out + 'px, 0px)'
                  '-moz-transform': 'translate3d(0px, ' + out + 'px, 0px)'
                  '-o-transform': 'translate3d(0px, ' + out + 'px, 0px)'
                  'transform': 'translate3d(0px, ' + out + 'px, 0px)'
              wrapper.bind 'webkitTransitionEnd mozTransitionEnd oTransitionEnd transitionEnd', slideback
            when 'margin'
              if settings.orientation == 'horz'
                wrapper.animate { left: out }, parseFloat(time) * 1000, settings.easingMargin, slideback
              else if settings.orientation == 'vert'
                wrapper.animate { top: out }, parseFloat(time) * 1000, settings.easingMargin, slideback
        else
          slideback()
        bond.unbind 'mousemove touchmove'
        $(document).unbind 'mouseup touchend'
        false

      slideback = ->
        switch mode
          when 'css'
            if settings.orientation == 'horz'
              out = get3dCoord(0, wrapper)
            else if settings.orientation == 'vert'
              out = get3dCoord(1, wrapper)
          when 'margin'
            if settings.orientation == 'horz'
              out = parseFloat(wrapper.css('left'))
            else if settings.orientation == 'vert'
              out = parseFloat(wrapper.css('top'))
        if out > 0
          if out > maxOut
            out = maxOut
          switch mode
            when 'css'
              wrapper.css
                '-webkit-transform': 'translate3d(0px, 0px, 0px)'
                '-moz-transform': 'translate3d(0px, 0px, 0px)'
                '-o-transform': 'translate3d(0px, 0px, 0px)'
                'transform': 'translate3d(0px, 0px, 0px)'
            when 'margin'
              wrapper.animate {
                left: 0
                top: 0
              }, parseFloat(settings.timeBack) * 1000, settings.easingMargin
        else if out < -actualtall + bondtall
          if Math.abs(out - actualtall) > maxOut
            out = -actualtall - (settings.maxOut)
          X = (actualtall - bondtall).toString()
          switch mode
            when 'css'
              if settings.orientation == 'horz'
                wrapper.css
                  '-webkit-transform': 'translate3d(-' + X + 'px, 0px, 0px)'
                  '-moz-transform': 'translate3d(-' + X + 'px, 0px, 0px)'
                  '-o-transform': 'translate3d(-' + X + 'px, 0px, 0px)'
                  'transform': 'translate3d(-' + X + 'px, 0px, 0px)'
              else if settings.orientation == 'vert'
                wrapper.css
                  '-webkit-transform': 'translate3d(0px, -' + X + 'px, 0px)'
                  '-moz-transform': 'translate3d(0px, -' + X + 'px, 0px)'
                  '-o-transform': 'translate3d(0px, -' + X + 'px, 0px)'
                  'transform': 'translate3d(0px, -' + X + 'px, 0px)'
            when 'margin'
              if settings.orientation == 'horz'
                wrapper.animate { 'left': -X }, parseFloat(settings.timeBack) * 1000, settings.easingMargin
              else if settings.orientation == 'vert'
                wrapper.animate { 'top': -X }, parseFloat(settings.timeBack) * 1000, settings.easingMargin
        if mode == 'css'
          wrapper.css
            '-webkit-transition-timing-function': settings.easingCss
            '-webkit-transition-duration': settings.timeBack
            '-moz-transition-timing-function': settings.easingCss
            '-moz-transition-duration': settings.timeBack
            '-o-transition-timing-function': settings.easingCss
            '-o-transition-duration': settings.timeBack
            'transition-timing-function': settings.easingCss
            'transition-duration': settings.timeBack
        return

      if settings.orientation == 'horz'
        bondtall = bond.width()
      else if settings.orientation == 'vert'
        bondtall = bond.height()

      ### Calculating the actual width of the slide show, it is the sum of all slides ###

      box.children(settings.slideSelector).each ->
        if settings.orientation == 'horz'
          actualtall += $(this).width() + parseInt($(this).css('margin-left')) + parseInt($(this).css('margin-right'))
        else if settings.orientation == 'vert'
          actualtall += $(this).height() + parseInt($(this).css('margin-top')) + parseInt($(this).css('margin-bottom'))
        return

      ### Maximum out of bounds distance ###

      maxOut = Math.floor(Math.sqrt(actualtall) / 2)
      switch isMobile
        when false
          switch settings.desktopMode
            when 'move'
              mode = 'move'
              bond.bind 'mousemove', (e) ->
                motionengine e
                return
              bond.bind 'mouseleave', (e) ->
                stopmotion e
                return
            when 'touchCss'
              mode = 'css'
              bond.bind 'mousedown touchstart', (e) ->
                touchstart e
                return
              wrapper.bind 'mousedown', (e) ->
                e.preventDefault()
                touchstart e
                return
              bond.find('a').bind 'click', (e) ->
                if delta != 0
                  return false
                return
            when 'touchMargin'
              mode = 'margin'
              bond.bind 'mousedown touchstart', (e) ->
                touchstart e
                return
              wrapper.bind 'mousedown', (e) ->
                e.preventDefault()
                touchstart e
                return
              bond.find('a').bind 'click', (e) ->
                if delta != 0
                  return false
                return
        when true
          switch settings.mobileMode
            when 'touchCss'
              mode = 'css'
              bond.bind 'mousedown touchstart', (e) ->
                touchstart e
                return
              bond.find('a').bind 'click', (e) ->
                if delta != 0
                  return false
                return
            when 'touchMargin'
              mode = 'margin'
              bond.bind 'mousedown touchstart', (e) ->
                touchstart e
                return
              bond.find('a').bind 'click', (e) ->
                `var startShift`
                if delta != 0
                  return false
                return

      ### Setting startup position ###

      if settings.startPos != 0
        startShift = ((bondtall - actualtall) / settings.startPos).toString()
      else
        startShift = 0
      switch mode
        when 'css'
          switch settings.orientation
            when 'horz'
              wrapper.css
                '-webkit-transform': 'translate3d(' + startShift + 'px, 0px, 0px)'
                '-moz-transform': 'translate3d(' + startShift + 'px, 0px, 0px)'
                '-o-transform': 'translate3d(' + startShift + 'px, 0px, 0px)'
                'transform': 'translate3d(' + startShift + 'px, 0px, 0px)'
            when 'vert'
              wrapper.css
                '-webkit-transform': 'translate3d(0px, ' + startShift + 'px, 0px)'
                '-moz-transform': 'translate3d(0px, ' + startShift + 'px, 0px)'
                '-o-transform': 'translate3d(0px, ' + startShift + 'px, 0px)'
                'transform': 'translate3d(0px, ' + startShift + 'px, 0px)'
        when 'move', 'margin'
          switch settings.orientation
            when 'horz'
              wrapper.css 'left', startShift + 'px'
            when 'vert'
              wrapper.css 'top', startShift + 'px'
      box.children(settings.slideSelector).click ->
        N = box.children(settings.slideSelector).index(this)
        settings.slideClickCallback N, delta
        return
      return