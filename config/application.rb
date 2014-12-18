require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# DO NOT call Bundler.require !!! Here's why:
#   http://myronmars.to/n/dev-blog/2012/12/5-reasons-to-avoid-bundler-require

# Dependencies for assets:precompile
require 'jquery-rails'
require 'turbolinks'
require 'rabl'

module Comparitron
  # This class is part of standard Rails configuration.
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record
    # auto-convert to this zone.
    # Run 'rake -D time' for a list of tasks for finding time zone names.
    # Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from
    # config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[
    #   Rails.root.join('my', 'locales', '*.{rb,yml}').to_s
    # ]
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
      g.fixture_replacement :factory_girl
    end

    config.eager_load_paths << Rails.root.join('lib')
  end
end
