source 'https://rubygems.org'
source "https://b8ab84f5:2186dcf8@gems.contribsys.com/"

ruby '2.2.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

gem 'pg'
gem 'pg_search'
gem 'unicorn'
gem 'rack-timeout'
gem 'thin'
gem 'flip'
gem 'newrelic_rpm'
gem 'devise'
gem 'devise_security_extension', git: 'https://github.com/phatworx/devise_security_extension.git'
gem 'aws-sdk'
gem 'connection_pool'
gem 'sidekiq-pro'
gem 'jquery-ui-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc

gem 'responders'
gem 'thor-rails'
gem 'roo'

# assets
gem 'sass-rails'
gem 'haml-rails'
gem 'soda-ruby', require: 'soda'
gem 'bourbon'
gem 'neat'
gem 'uglifier' # Use Uglifier as compressor for JavaScript assets
gem 'jquery-rails'
gem 'turbolinks'
gem 'backbone-rails'

group :development do
  gem 'rubocop'
  gem 'cane'
  gem 'overcommit'
  gem 'foreman'
  gem 'web-console'
  gem 'rails_best_practices'
  gem 'annotate'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'jasmine'
  gem 'jasmine-jquery-rails'
  gem 'dotenv'
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'codeclimate-test-reporter'
  gem 'rails-perftest'
  gem 'ruby-prof'
  gem 'timecop'
  gem 'fakeredis'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
  gem 'airbrake'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
