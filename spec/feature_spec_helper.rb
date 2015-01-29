require 'rails_helper'
require 'capybara'
require 'capybara/rails'
require 'selenium-webdriver'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :chrome

# Macros for logging in users
RSpec.configure do |config|
  config.extend WardenMacros, type: :feature
  config.include BrowserSizeHelpers, type: :feature
end
Warden.test_mode!