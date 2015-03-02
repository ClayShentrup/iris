require_relative './warden_macros'

RSpec.configure do |config|
  config.extend WardenMacros, type: :feature
end
