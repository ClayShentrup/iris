require_relative './feature_flip_macros'
RSpec.configure do |config|
  config.include FeatureFlipMacros, type: :controller
end
