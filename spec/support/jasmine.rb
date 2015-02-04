require_relative './jasmine_macros'

RSpec.configure do |config|
  config.extend JasmineMacros, type: :controller
end
