var path = require('path');
var webpack = require('webpack');

module.exports = {
  devtool: 'eval',
  entry: [
    'webpack-dev-server/client?http://localhost:3000',
    'webpack/hot/only-dev-server',
    './src/App'
  ],
  output: {
    path: path.join(__dirname, 'build'),
    filename: 'bundle.js',
    publicPath: 'http://localhost:3000/'
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin(),
    new webpack.DefinePlugin({
      "process.env": {
        "NODE_ENV": JSON.stringify("development")
      }
    }),    
  ],
  resolve: {
    extensions: ['', '.js', '.jsx', '.cjsx', '.coffee', '.json']
  },
  module: {
    loaders: [{
      test: /\.jsx?$/,
      loaders: ['react-hot', 'babel'],
      include: path.join(__dirname, 'src')
    },{
      test: /\.js?$/,
      loaders: ['react-hot', 'babel'],
      include: path.join(__dirname, 'src')
    },{
      test: /\.cjsx?$/,
      loaders: ['react-hot', 'coffee', 'cjsx'],
      include: path.join(__dirname, 'src')
    },{
      test: /\.coffee?$/,
      loaders: ['react-hot', 'coffee'],
      include: path.join(__dirname, 'src')
    },{
      test: /\.json?$/,
      loader: "json"
    },{
      test: /\.css$/,
      loader: "style-loader!css-loader"
    },{
      test: /\.scss$/,
      include: [path.resolve(__dirname, "src")],
      loaders: ["style", "css", "autoprefixer-loader", "sass?sourceMap"]
    }]
  }
};
