require('./vendors/cssua.js')
angular = require('angular')
require('gsap')
require('gsap/src/uncompressed/utils/Draggable.js')
require('gsap/src/uncompressed/plugins/ScrollToPlugin.js')
require('./plugins/ThrowPropsPlugin.min.js')
require('./plugins/DrawSVGPlugin.min-modif.js')
require('imports-loader?this=>window!./vendors/preloadjs-0.6.1.min.js')
require('lodash')
#require('./plugins/angular-ui-utils/ui-utils.js')
#require('imports-loader?this=>window!./vendors/modernizr/modernizr.js')
require('angular-animate')
#$ = require('jquery')
#require('./plugins/angular-youtube-embed.js')
#Snap = require("imports-loader?this=>window,fix=>module.exports=0!./vendors/snap.svg.js")
#require('./plugins/angular-google-maps.min.js')
#require('classie')
#require('./plugins/draggabilly.pkgd.min.js')
#require('./plugins/svgLoader.js')
#require('./plugins/mb-scrollbar.js')
require('./angular/app.coffee')(angular)