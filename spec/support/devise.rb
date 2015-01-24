require_relative './devise_macros'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.extend DeviseMacros, type: :controller

  config.include Warden::Test::Helpers, type: :request
  config.before type: :request do
    Warden.test_mode!
  end
end
