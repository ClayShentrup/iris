require 'rails_helper'
require 'capybara'
require 'capybara/rails'
require 'selenium-webdriver'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    service_log_path: Rails.root.join('log', 'chromedriver.out'),
    desired_capabilities: {
      # chrome.switches is used to pass arguments to Chrome itself and not the
      # chromedriver executable
      'chrome.switches' => %w[
        --enable-logging
        --v=1
      ],
    },
  )
end

Capybara.default_driver = :chrome

Capybara.server do |app, port|
  require 'rack/handler/thin'
  Rack::Handler::Thin.run(app, Port: port)
end

RSpec.configure do |config|
  config.include BrowserSizeHelpers, type: :feature
  config.include AuthenticationHelpers, type: :feature
end
