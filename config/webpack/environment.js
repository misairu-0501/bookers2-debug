const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',//(修正前)'jquery/src/jquery'
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js',
    "window.jQuery": "jquery"
  })
)

module.exports = environment
