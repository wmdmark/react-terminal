var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: [
    './src/App'
  ],
  output: {
    path: path.join(__dirname, 'build'),
    filename: 'bundle.js'
  },
  plugins: [
    new webpack.NoErrorsPlugin(),
    new webpack.optimize.UglifyJsPlugin(),
    new webpack.DefinePlugin({
      "process.env": {
        "NODE_ENV": JSON.stringify("production")
      }
    }),
  ],
  resolve: {
    extensions: ['', '.js', '.jsx', '.cjsx', '.coffee', '.json']
  },
  node: {
    fs: ""
  },
  module: {
    loaders: [{
      test: /\.jsx?$/,
      loaders: ['babel'],
      include: path.join(__dirname, 'src')
    },{
      test: /\.js?$/,
      loaders: ['babel'],
      include: path.join(__dirname, 'src')
    },{
      test: /\.cjsx?$/,
      loaders: ['coffee', 'cjsx?sourceMap'],
      include: path.join(__dirname, 'src')
    },{
      test: /\.coffee?$/,
      loaders: ['coffee'],
      include: path.join(__dirname, 'src')
    },{
      test: /\.json?$/,
      loader: "json"
    },{
      test: /\.css$/,
      include: path.join(__dirname, 'src'),
      loader: "style-loader!css-loader"
    },{
      test: /\.scss$/,
      include: [path.resolve(__dirname, "src")],
      loaders: ["style", "css", "autoprefixer-loader", "sass?sourceMap"]
    },,{
      test: /\.json$/,
      loader: "json-loader"
    },
    {
      test: /\.txt$/,
      include: path.join(__dirname, 'src'),
      loader: "raw-loader"
    },{
      test: /\.md$/,
      include: path.join(__dirname, 'src'),
      loaders: ["html", "remarkable"]
    }]
  }
};
