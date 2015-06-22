module.exports = (angular)->
  'use strict'
  services = angular.module("App.popup.popup-services",[])
#  #Получение данных из json-файла
#  services.factory "dataService",[
#    "$resource"
#    ($resource) ->
#      $resource("app/json/:jsonName",{},
#        query :
#          method : "GET"
#          isArray : true
#        charge :
#          method : 'POST'
#          params : {charge : true}
#      )
#  ]
#  services.factory "getDataString",[
#    "$resource"
#    ($resource) ->
#      $resource("controllers/:namePage",{},
#        query :
#          method : "GET"
#          isArray : false
#        charge :
#          method : 'POST'
#          params : {charge : true}
#      )
#  ]