=begin
DO NOT call Bundler.require !!! Here's why:
  http://myronmars.to/n/dev-blog/2012/12/5-reasons-to-avoid-bundler-require

The goal is to require the minimum number of dependencies, and as late/lazily
as possible, so our app maintains a fast boot time. So, for instance, if you
only need the rake tasks from a Gem, see if it's possible to just require the
rake tasks from the gem, instead of the entire gem. Every gem is different (e.g.
some use monkey patching while others merely provide new classes and/or
methods), so the strategy will vary dependending on the gem.
=end

# Dependencies for assets:precompile
require 'jquery-rails'
require 'turbolinks'
require 'bourbon'
require 'neat'
require 'backbone-rails'
require 'jquery-ui-rails'

# Dependencies for Puma
require 'rack-timeout' unless Rails.env.test?
# Dependency for feature flip
require 'flip'

require 'devise'
require 'devise_security_extension'
require 'rails-settings-cached'

if Rails.env.development? || Rails.env.test?
  require 'jasmine'
  load 'rails/test_unit/testing.rake'
  load 'rails/perftest/railties/testing.tasks'
  require 'jasmine-jquery-rails'
end

if Rails.env.development?
  if defined?(Rails::Console)
    require 'awesome_print'
    require 'pry-byebug'
    require 'pry-rails'
    require 'pry-coolline'
  end
  require 'dotenv'
  require 'rspec-rails'
end

if Rails.env.production?
  require 'airbrake'
  require 'newrelic_rpm'
end
