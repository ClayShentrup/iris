require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

require_relative 'gem_dependencies'

Dotenv.load if defined?(Dotenv)

module Iris
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
      g.helper false # Presenters are preferable to helpers.

      require 'haml-rails'
      g.template_engine :haml

      require 'sass-rails'
      config.sass.preferred_syntax = :sass

      g.test_framework :rspec,
                       view_specs: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.autoload_paths << Rails.root.join('lib')
    config.turbolinks_debugging_enabled = false
    config.action_controller.action_on_unpermitted_parameters = :raise
    config.force_ssl = true

    config.aws_bucket_name = [
      'dabo-iris',
      Rails.env,
      ENV.fetch('ACCEPTANCE_APPLICATION_STORY_ID', nil),
    ].compact.join('-')

    config.aws_credentials = {
      access_key_id: ENV.fetch('DABO_AWS_ACCESS_KEY_ID', ''),
      secret_access_key: ENV.fetch('DABO_AWS_SECRET_ACCESS_KEY', ''),
    }

    # This is Mayo's time zone; naively setting this for the whole app for now.
    # It is used for reporting, and will eventually be set per client
    # "installation" via config vars.
    config.client_time_zone = Time.find_zone!('Central Time (US & Canada)')
    config.action_dispatch.rescue_responses.merge!(
      'PublicChartTree::PublicChartNotFoundError' => :not_found,
    )

    host_name = ENV.fetch('APP_NAME')
    config.action_mailer.default_url_options = {
      host:     "#{host_name}.herokuapp.com",
      protocol: 'https',
    }

    config.action_mailer.smtp_settings = {
      user_name: ENV.fetch('MAILTRAP_USERNAME', nil),
      password: ENV.fetch('MAILTRAP_PASSWORD', nil),
      address: ENV.fetch('MAILTRAP_DOMAIN', nil),
      domain: ENV.fetch('MAILTRAP_DOMAIN', nil),
      port: ENV.fetch('MAILTRAP_PORT', nil),
      authentication: :cram_md5,
      enable_starttls_auto: true,
    }
  end
end
