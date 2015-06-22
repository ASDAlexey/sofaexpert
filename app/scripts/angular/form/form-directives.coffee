module.exports = (angular)->
  'use strict'
  directive = angular.module("App.form.form-directives",[])
  directive.directive 'fileInput',[
    "$parse"
    "$timeout"
    ($parse,$timeout) ->
      restrict : "A"
      link : (scope,element,attr)->
        angular.element(document).ready ->
          $(element).parent()[0].ondragover = ->
            $(element).parent().addClass('hover')
            false
          $(element).parent()[0].ondragleave = ->
            $(element).parent().removeClass('hover')
            false
          element.bind 'change',->
            $parse(attr.fileInput).assign(scope,element[0].files)
            files = scope.files[attr.nameFiles]
            angular.forEach files,(file) ->
              unless _.findWhere(scope.filesObj[attr.nameFiles].arrFilesBeforeSend,{name : file.name})
                if(file.type is "image/jpeg" or file.type is "image/png")
                  fr = new FileReader()
                  fr.onload = (event)->
                    scope.filesObj[attr.nameFiles].arrFilesBeforeSend.push {
                      id : _.uniqueId('file_')
                      file : file
                      name : file.name
                      src : @result
                      size : event.total
                    }
                    scope.$apply()
                  fr.readAsDataURL file
            element.val(null)
  ]