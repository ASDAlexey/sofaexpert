module.exports = (angular)->
  'use strict'
  angular.module("App.form.form-filters",[])
  .filter "splitSpace",->
    (input) ->
      if input
        input.toString().replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g,'$1 ')
  .filter "persent",->
    (input) ->
      if input
        input * 100
  .filter "toMb",->
    (input) ->
      if input
        Math.round(input * 100 / 1048576) / 100
  .filter "round2", ->
    (quantity) ->
      Math.ceil(quantity * 100) / 100