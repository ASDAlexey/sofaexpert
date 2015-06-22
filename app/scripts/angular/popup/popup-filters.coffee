module.exports = (angular)->
  'use strict'
  angular.module('App.popup.popup-filter', [])
  .filter 'round3', [
    (quantity) ->
      Math.ceil(quantity * 1000) / 1000
  ]
  .filter "splitSpace", ->
    (input) ->
      input.toString().replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g, '$1 ')