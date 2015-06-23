module.exports = (angular)->
  'use strict'
  controller = angular.module("App.form.form-controllers",[])
  controller.controller "SearchCtrl",[
    "$scope"
    "$rootScope"
    "$timeout"
    "$window"
    ($scope,$rootScope,$timeout,$window) ->
      $rootScope.formIsValide = false
      $scope.form_set_pristine = (form) ->
        if form.$setPristine
          form.$setPristine()
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      $scope.send = (dataForm,formValidate,action)=>
        if formValidate.$valid
          $rootScope.formIsValide = true
          get = action + "&keyword=#{dataForm.search}"
          $window.location.href = get
          $scope.form_set_pristine(formValidate)
          $scope.dataForm = {}
        else
          $scope.form_set_dirty(formValidate)
      $rootScope.hideThank = ()->
        $rootScope.formIsValide = false
  ]
  controller.controller "SubscribeCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    ($scope,$http,$rootScope,$timeout) ->
      $rootScope.formIsValide = false
      $scope.form_set_pristine = (form) ->
        if form.$setPristine
          form.$setPristine()
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      $scope.send = (dataForm,dataFormHidden,formValidate)=>
        if formValidate.$valid
          $rootScope.formIsValide = true
          $scope.dataForm = {}
          $timeout(->
            $rootScope.hideThank()
          ,3000)
          $http(
            url : "./controller.php"
            method : "POST"
            data : angular.extend(dataForm,dataFormHidden)
          )
          $scope.form_set_pristine(formValidate)
        else
          $scope.form_set_dirty(formValidate)
      $rootScope.hideThank = ()->
        $rootScope.formIsValide = false
  ]
  controller.controller "FormCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    ($scope,$http,$rootScope,$timeout,windowProp) ->
      $rootScope.formIsValide = false
      $scope.form_set_pristine = (form) ->
        if form.$setPristine
          form.$setPristine()
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      $scope.send = (task,dataForm,formValidate)=>
        if formValidate.$valid
          $rootScope.formIsValide = true
          $timeout(->
            $rootScope.hideThank()
          ,2000)
          dataForm.task = task
          $http
            url : "./controllers/post.php"
            method : "POST"
            data : dataForm
          $scope.form_set_pristine(formValidate)
          $scope.dataForm = {}
        else
          $scope.form_set_dirty(formValidate)
      $rootScope.hideThank = ()->
        $rootScope.formIsValide = false
  ]
  controller.controller "FileCtrl",[
    '$scope'
    "$http"
    "$q"
    "$rootScope"
    "$timeout"
    ($scope,$http,$q,$rootScope,$timeout) ->
#custom select
      $scope.zIndex = new Array(7)
      $scope.zIndex = _.fill($scope.zIndex,false)
      $scope.fOpen = (number)->
        $scope.zIndex[number] = true
      $scope.fClose = (number)->
        $scope.zIndex[number] = false
      $scope.select = []
      $scope.resultArr = []
      $scope.defaultSelect = []
      $scope.setSelect = (arr,number,placeholder,defaultObj)->
        $scope.select[number] = []
        $scope.select[number].push {name : placeholder.name,maker : "",ticked : true,value : placeholder.value}
        angular.forEach arr,(value,key)->
          obj = {
            name : value.name
            value : value.value
            maker : ""
            ticked : false
          }
          $scope.select[number].push obj
        $scope.resultArr = []
        angular.forEach $scope.select,(value,key)->
          $scope.resultArr.push _.result(_.findWhere(value,{'ticked' : true}),'value')
        $scope.defaultSelect.push defaultObj
      #validation form
      $rootScope.formIsValide = false
      $scope.form_set_pristine = (form) ->
        if form.$setPristine
          form.$setPristine()
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      #file upload
      $rootScope.currentLoadPersent = 0
      $scope.filesObj = {}
      $scope.setFileObj = (name)->
        $scope.filesObj[name] = {
          arrFilesServer : []
          arrFilesBeforeSend : []
          currentLoadPersent : 0
        }
      $scope.removeServerFile = ()->

      $scope.removeFile = (file,nameGroup)->
        $scope.filesObj[nameGroup].arrFilesBeforeSend.splice($scope.filesObj[nameGroup].arrFilesBeforeSend.indexOf(file),1)
      $scope.send = (filesObj,url,dataForm,formValidate)=>
        if formValidate.$valid
          $scope.resultSelect = []
          angular.forEach $scope.select,(value,key)->
            $scope.resultSelect.push _.result(_.findWhere(value,{'ticked' : true}),'name')
          promise = $q.all({})
          bufferArr = {}
          currentLoad = 0
          total = 0
          angular.forEach filesObj,(value,key) ->
            total += _.sum(value.arrFilesBeforeSend,'size')
          angular.forEach filesObj,(v,k) ->
            bufferArr[k] = []
            angular.forEach v.arrFilesBeforeSend,(value,key) ->
              fd = new FormData()
              fd.append value.id,value.file
              promise = promise.then(->
                $http(
                  url : url
                  method : "POST"
                  data : fd
                  transformRequest : angular.identity,
                  headers : {'Content-Type' : undefined}
                ).then (res) ->
                  bufferArr[k].push res.data[0]
                  currentLoad += _.result _.findWhere(v.arrFilesBeforeSend,{id : res.data[0].id}),'size'
                  $rootScope.currentLoadPersent = parseInt(currentLoad * 100 / total)
              )
          promise.then ->
            if dataForm
              fDataForm = new FormData()
              angular.forEach dataForm,(value,key) ->
                fDataForm.append key,value
              $http(
                url : url
                method : "POST"
                data : fDataForm
                transformRequest : angular.identity,
                headers : {'Content-Type' : undefined}
              )
            $rootScope.formIsValide = true
            $scope.form_set_pristine(formValidate)
            $timeout(->
              $rootScope.hideThank()
            ,2000)
            angular.forEach $scope.filesObj,(value,key) ->
              $scope.filesObj[key].arrFilesServer = _.union($scope.filesObj[key].arrFilesServer,bufferArr[key])
              $rootScope.currentLoadPersent = 0
              $scope.filesObj[key].arrFilesBeforeSend.length = 0
        else
          $scope.form_set_dirty(formValidate)
  ]
  controller.controller "ContactsCtrl",[
    '$scope'
    "$http"
    "$q"
    "$rootScope"
    "$timeout"
    ($scope,$http,$q,$rootScope,$timeout) ->
      #custom select
      $scope.setCountSelects = ()->
        $scope.zIndex = new Array(2)
        $scope.zIndex = _.fill($scope.zIndex,false)
      $scope.fOpen = (number)->
        $scope.zIndex[number] = true
      $scope.fClose = (number)->
        $scope.zIndex[number] = false
      $scope.selects = {}
      $scope.setSelect = (selectObj)->
        $scope.selects[selectObj.name] = []
        $scope.selects[selectObj.name].push {
          name : selectObj.placeholder.text
          value : selectObj.placeholder.value
          maker : ""
          ticked : true
        }
        angular.forEach selectObj.options,(value,key)->
          unless selectObj.placeholder.text is value.text
            $scope.selects[selectObj.name].push {
              name : value.text
              value : value.value
              maker : ""
              ticked : false
            }
      #validation form
      $rootScope.formIsValide = false
      $scope.form_set_pristine = (form) ->
        if form.$setPristine
          form.$setPristine()
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      $scope.send = (dataForm,formValidate)=>
        if formValidate.$valid
          $scope.resultSelects = []
          angular.forEach $scope.selects,(value,key)->
            if _.findWhere(value,{'ticked' : true}).value
              $scope.resultSelects.push {
                "name" : key
                "value" : _.result(_.findWhere(value,{'ticked' : true}),'value')
              }
          dataForm = angular.extend(dataForm,{selects : $scope.resultSelects})
          dataForm.task = "filter"
          $scope.form_set_pristine(formValidate)
          $http(
            url : "./controller.php"
            method : "POST"
            data : dataForm
          ).then((response)->
            $scope.products = response.data
          )
        else
          $scope.form_set_dirty(formValidate)
      $scope.clear = (formValidate)=>
        $scope.form_set_pristine(formValidate)
      $rootScope.hideThank = ()->
        $rootScope.formIsValide = false
  ]