require 'active_record'
require 'shoulda/matchers'
require 'factory_girl'
require './spec/database_cleaning_strategy'

if ActiveRecord::Migrator.needs_migration?
  require_relative '../config/application'
  ActiveRecord::Base.maintain_test_schema = true
  ActiveRecord::Migration.maintain_test_schema!
end

RSpec.configure do |config|
  DatabaseCleaningStrategy.call(config)

  FactoryGirl.find_definitions
  config.include(FactoryGirl::Syntax::Methods)
end

def clean_db_after_tests
end
