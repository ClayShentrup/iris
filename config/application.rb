require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# Doing this instead.
#   http://myronmars.to/n/dev-blog/2012/12/5-reasons-to-avoid-bundler-require
# Bundler.require(*Rails.groups)

# Dependencies for assets:precompile
require 'jquery-rails'
require 'turbolinks'

module Comparitron
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.generators do |g|
      g.assets false
      g.helper false

      require 'haml-rails'
      g.template_engine :haml

      require 'sass-rails'
      config.sass.preferred_syntax = :sass

      g.test_framework :rspec,
        view_specs: false
    end
  end
end