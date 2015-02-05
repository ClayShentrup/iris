require 'rails_helper'
require 'capybara'
require 'capybara/rails'
require 'selenium-webdriver'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :chrome

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  # Macros for logging in users
  config.extend WardenMacros, type: :feature
  config.include BrowserSizeHelpers, type: :feature
end

Warden.test_mode!
