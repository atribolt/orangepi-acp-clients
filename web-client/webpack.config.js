//@ts-check


const CopyPlugin = require('copy-webpack-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const path = require('path')


module.exports = {
  entry: './scripts/index.js',
  output: {
    path: path.resolve(__dirname, './www'),
    filename: 'index.js'
  },
  module: {
    rules: [
      { test: /\.css$/, use: ['style-loader', 'css-loader'] }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './index.html'
    }),
    new CopyPlugin({
      patterns: [
        { from: 'styles', to: './styles' }
      ]
    })
  ],
  mode: 'production'
}