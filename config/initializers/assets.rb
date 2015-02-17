Rails.application.config.tap do |config|
  config.assets.precompile += [
    'flip.css',
    'turbolinks_debugging.js',
    'application_core.js'
  ]
end
