module.exports = (angular)->
  'use strict'
  services = angular.module("App.form.form-services",[])
#  services.factory 'Discont',($http,$q,$window) ->
#  # Объявляем класс модели данных
#  #  url = 'http://'+$window.location.host+'/controller.php'
#    url = 'http://' + $window.location.host + '/json/discont.json'
#    obj =
#      getDiscont : (cupon,task)->
#        deferred = $q.defer()
#        discont = ''
#        $http.get(url + "?cupon=#{cupon}&#{task}").success((data) ->
#          discont = data.discont
#          deferred.resolve discont
#        ).error ->
#          deferred.reject()
#        return deferred.promise
#    obj