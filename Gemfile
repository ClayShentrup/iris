source 'https://rubygems.org'
ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

gem 'pg'
gem 'unicorn'
gem 'rack-timeout'

# gem 'therubyracer',  platforms: :ruby
gem 'jbuilder'
gem 'sdoc', group: :doc

gem 'active_model_serializers'

# assets
gem 'sass-rails'
gem 'haml-rails'
gem 'soda-ruby', require: 'soda'
gem 'rabl'
gem 'pry'
gem 'pry-nav'
gem 'bourbon'
gem 'neat'
gem 'uglifier'
gem 'jquery-rails'
gem 'turbolinks'

group :development do
  gem 'rubocop'
  gem 'cane'
  gem 'pre-commit'
  gem 'foreman'
  gem 'better_errors'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'codeclimate-test-reporter'
end

group :production do
  gem 'rails_12factor'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
