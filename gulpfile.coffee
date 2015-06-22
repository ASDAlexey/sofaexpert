gulp = require('gulp')
plumber = require('gulp-plumber')
coffee = require('gulp-coffee')
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')
pngquant = require('imagemin-pngquant')
imagemin = require('gulp-imagemin')
spritesmith = require('gulp.spritesmith')
sass = require('gulp-sass')
prefix = require('gulp-autoprefixer')
please = require('gulp-pleeease')
jade = require('gulp-jade')
util = require("util")
data = require('gulp-data')
stylus = require('gulp-stylus')
scandir = require('scandir')
connect = require('gulp-connect')
gutil = require('gulp-util')
minifyHTML = require('gulp-minify-html');
gulp.task 'imagemin',->
  gulp.src('./app/images/**/*').pipe(imagemin(
    progressive : true
    svgoPlugins : [{removeViewBox : false}]
    use : [pngquant()])).pipe gulp.dest('./app/images')
gulp.task 'watchConsole',->
  exec = require('child_process').exec
  watch = require('gulp-watch')
  watch './app/images/**/*.{jpg,jpeg,png,gif}',->
    exec 'chmod 755 -R ./app/images'
gulp.task 'stylus',->
  gulp.src('./app/styles/*.styl')
  .pipe(plumber(errorHandler : (error,file) ->
      console.log error.message
      @emit 'end'
    ))
  .pipe(stylus(
      'include css' : true
      sourcemap :
        inline : true
        sourceRoot : '.'
        basePath : './app/styles'
    ))
  .pipe(please(
      'minifier' : true
      "autoprefixer" : {
        'browsers' : [
          'last 6 versions'
          'Android 4'
          'ie 9'
          'ie 10'
          'ie 11'
        ]
      },
      'filters' : true
      'oldIE' : true
      'rem' : true
      'pseudoElements' : true
      'opacity' : true
      'import' : true
      'mqpacker' : true
      'next' : true,
      preserveHacks : true,
      removeAllComments : true
      sourcemaps : true
    ))
  .pipe gulp.dest('./app/styles')
  .pipe(connect.reload())
gulp.task 'sprite',->
  spriteData = gulp.src('./app/images/sprite/*.*').pipe(spritesmith(
    imgName : '../images/sprite.png'
    cssName : 'utilities/_sprite.styl'
    padding : 3))
  spriteData.img.pipe gulp.dest('./app/images/')
  spriteData.css.pipe gulp.dest('./app/styles/')
gulp.task 'jade',->
  data = {}
  data.images = {}
  data.mainSlider = require './app/json/main-slider.json'
  #  data.images.newSlider = scandir('./app/images/new-slider','names')
  gulp.src('./app/jade/pages/*.jade')
  .pipe(plumber(errorHandler : (error,file) ->
      console.log error.message
      @emit 'end'
    ))
  .pipe(jade(
      pretty : true
      locals : data
    ))
  .pipe gulp.dest('./app/')
  .pipe(connect.reload())
gulp.task 'connect',->
  connect.server
    root : 'app'
    livereload : true
    port : 3000
gulp.task 'watch',->
  gulp.watch './app/styles/**/*.styl',['stylus']
  gulp.watch './app/styles/_sprite.styl',['sprite']
  gulp.watch './app/jade/**/*.jade',['jade']
  gulp.watch './app/json/**/*.json',['jade']
gulp.task 'default',[
  'sprite'
  'stylus'
  'jade'
  'watch'
  'connect'
]