Rails.application.config.tap do |config|
  config.assets.precompile += %w( flip.css turbolinks_debugging.js )
end
