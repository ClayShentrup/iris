require 'active_record'
require 'shoulda/matchers'

if ActiveRecord::Migrator.needs_migration?
  require_relative '../config/application'
  ActiveRecord::Base.maintain_test_schema = true
  ActiveRecord::Migration.maintain_test_schema!
end

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      fail ActiveRecord::Rollback
    end
  end

  require 'factory_girl'
  FactoryGirl.find_definitions
  config.include(FactoryGirl::Syntax::Methods)
end
