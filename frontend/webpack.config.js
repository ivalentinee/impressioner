const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  entry: {
    slides: ['babel-polyfill', './frontend/application/slides.js'],
    'control-panel': ['babel-polyfill', './frontend/application/controlPanel.js'],
  },
  output: {
    path: `${__dirname}/../priv/static/assets`,
    filename: '[name].js',
  },
  devtool: 'source-map',
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
      },
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: 'css-loader',
              options: {
                modules: true,
                localIdentName: '[path][name]__[local]--[hash:base64:5]',
              },
            },
            { loader: 'postcss-loader' },
          ],
        }),
      },
      {
        test: /\.(png|jpg|gif)$/,
        use: [{
          loader: 'file-loader',
          options: {
            publicPath: '/assets/',
          },
        }],
      },
    ],
  },
  plugins: [
    new ExtractTextPlugin('[name].css'),
  ],
};
