require 'active_record'
require 'shoulda/matchers'
require 'database_cleaner'

if ActiveRecord::Migrator.needs_migration?
  require_relative '../config/application'
  ActiveRecord::Base.maintain_test_schema = true
  ActiveRecord::Migration.maintain_test_schema!
end
