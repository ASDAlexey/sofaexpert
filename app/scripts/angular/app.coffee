module.exports = (angular)->
  require('./nav/nav.coffee')(angular)
  require('./form/form.coffee')(angular)
  require('./tabs/tabs.coffee')(angular)
  require('./slider/slider.coffee')(angular)
  require('./svg/svg.coffee')(angular)
  require('./animate/animate.coffee')(angular)
  require('./preloader/preloader.coffee')(angular)
  app = angular.module("App",[
    'ngAnimate'
    'App.animate'
    'multi-select'
    'ui.mask'
    'App.form'
    'App.tabs'
    'App.slider'
    'App.svg'
    'App.preloader'
    'App.nav'
  ])
  app.run(($timeout,$rootScope)->
    $timeout(->
      $rootScope.load = true
    ,500)
  )
  angular.bootstrap(document.getElementsByTagName("html"),["App"])