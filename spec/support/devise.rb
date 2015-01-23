require_relative './devise_macros'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.extend DeviseMacros
end
