require 'rails_helper'
require 'capybara'
require 'capybara/rails'
require 'selenium-webdriver'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :chrome

Capybara.server do |app, port|
  require 'rack/handler/thin'
  Rack::Handler::Thin.run(app, Port: port)
end

RSpec.configure do |config|
  config.extend WardenMacros, type: :feature
  config.include BrowserSizeHelpers, type: :feature
  config.include AuthenticationHelpers, type: :feature
end

Warden.test_mode!
