Rails.application.config.tap do |config|
  config.assets.precompile << 'turbolinks_debugging.js'
  #config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
  #config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
end
