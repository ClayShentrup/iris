require_relative './feature_flip_macros'
RSpec.configure do |config|
  config.include FeatureFlipMacros, type: :controller
  config.include FeatureFlipMacros, type: :feature
end
