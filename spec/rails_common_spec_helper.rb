require 'active_record'
require 'shoulda/matchers'
require 'database_cleaner'

if ActiveRecord::Migrator.needs_migration?
  require_relative '../config/application'
  ActiveRecord::Base.maintain_test_schema = true
  ActiveRecord::Migration.maintain_test_schema!
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  require 'factory_girl'
  FactoryGirl.find_definitions
  config.include(FactoryGirl::Syntax::Methods)
end
