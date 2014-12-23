Rails.application.config.tap do |config|
  config.assets.precompile << 'turbolinks_debugging.js'
end
