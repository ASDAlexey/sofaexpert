module.exports = (angular)->
  'use strict'
  services = angular.module("App.slider.slider-services",[])
  services.factory "MainSlider",[
    "$http"
    "$q"
    ($http,$q)->
#      class MainSlider
#        get : ->
      {
        get:()->
          deffered  = $q.defer()
          promise=$http.get('./json/main-slider.json').success (data)->
#            console.log(data)
            deffered.resolve(data)
          .error (data, status, headers, config)->
            deffered.reject(status)
          return deffered.promise;
      }
  ]