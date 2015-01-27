require_relative './devise_macros'

RSpec.configure do |config|
  config.extend DeviseMacros, type: :controller
end
