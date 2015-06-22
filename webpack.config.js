'use strict';
var webpack=require('webpack');
var BowerWebpackPlugin=require("bower-webpack-plugin");
var ngminPlugin=require("ngmin-webpack-plugin");
module.exports={
    context:__dirname+'\\app\\scripts',
    entry:'.\\index.coffee',
    output:{
        path:__dirname+'\\app',
        filename:'bundle.js'
    },
    devtool:'source-map',
    cache:true,
    debug:true,
    //externals: {
    //    //don't bundle the 'react' npm package with our bundle.js
    //    //but get it from a global 'React' variable
    //    'react': 'React'
    //},
    //resolve:{
    //    extensions:['','.js','.jsx'],
    //    alias:{
    //        'TimelineMax':__dirname+'/app/scripts/greensock/TimelineMax.min.js'
    //        //'react':__dirname+'/app/vendors/react.js',
    //        //'SXTransformer':__dirname+'/app/vendors/JSXTransformer.js'
    //    }
    //},
    proxy:{
        "*":"http://localhost:3000"
    },
    resolve:{
        alias:{
            'TweenLite': 'gsap/src/uncompressed/TweenLite'
            //'angular':__dirname+'/app/vendors/angular.js'
            //'react':__dirname+'/app/vendors/react.js',
            //'SXTransformer':__dirname+'/app/vendors/JSXTransformer.js'
        }
    },
    module:{
        loaders:[
            //{test:/\.js$/,loader:'babel',exclude:/node_modules/},
            {test:/\.html$/,loader:'raw',exclude:/node_modules/},
            {test:/\.jade$/,loader:'raw!jade-html',exclude:/node_modules/},
            {test:/\.css$/,loader:'style!css',exclude:/node_modules/},
            {test:/\.styl$/,loader:'style!css!stylus',exclude:/node_modules/},
            {test:/\.coffee$/,loader:"coffee-loader"},
            {test:/.*\/app\/.*\.js$/,loader:"uglify"}
            //{
            //    test:/[\/\\]node_modules[\/\\]some-legacy-script[\/\\]index\.js$/,
            //    loader:"legacy"
            //}
            //{test:/\.jsx$/,loader:'jsx-loader?insertPragma=React.DOM&harmony'}
            //{test:/[\\\/]vendors[\\\/]modernizr[\\\/]modernizr\.js$/,loader:"imports?this=>window!exports?window.Modernizr"}
        ],
        preLoaders:[
            {
                test:/\.coffee$/,
                loader:"source-map-loader"
            }
        ]
    },
    plugins:[
        //new BowerWebpackPlugin(),
        //new webpack.ProvidePlugin({
        //    $:"jquery",
        //    jQuery:"jquery",
        //    "window.jQuery":"jquery",
        //    "root.jQuery":"jquery"
        //})

        new webpack.HotModuleReplacementPlugin(),
        //new ngminPlugin(),
        //new webpack.optimize.DedupePlugin(),
        //new webpack.optimize.UglifyJsPlugin({
        //    compress:{
        //        warnings:false
        //    },
        //    minimize:true
        //})
    ]
};
