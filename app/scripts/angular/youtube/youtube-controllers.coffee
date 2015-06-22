module.exports = (angular)->
  'use strict'
  controller = angular.module("App.youtube.youtube-controllers",[])
  controller.controller "YoutubeCtrl",[
    "$scope"
    "$rootScope"
    ($scope,$rootScope) ->
      $scope.playerVars = {
        controls : 0
      }
      $rootScope.youtubeVideo = []
      $scope.$on 'youtube.player.ready',($event,player) ->
        $rootScope.youtubeVideo.push {
          id : player.c.getAttribute('video-id').replace(/'/g,"")
          player : player
        }
        if $scope.backgroundVideo
          if player.getVideoUrl() is 'https://www.youtube.com/watch?v='+$scope.backgroundVideo
            player.playVideo()
            player.mute()
      $scope.$on 'youtube.player.ended',($event,player) ->
        player.playVideo()
      $scope.pauseVideo=(player)->
        player.pauseVideo()
  ]