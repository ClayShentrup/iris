ENV['RAILS_ENV'] = 'test'
require 'active_record'
require 'shoulda/matchers'
require 'factory_girl'
require './spec/support/database_cleaner'

if ActiveRecord::Migrator.needs_migration?
  require_relative '../config/application'
  ActiveRecord::Base.maintain_test_schema = true
  ActiveRecord::Migration.maintain_test_schema!
end

RSpec.configure do |config|
  FactoryGirl.find_definitions
  config.include(FactoryGirl::Syntax::Methods)
end
