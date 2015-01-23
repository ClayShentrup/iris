require 'rails_common_spec_helper'

unless Rails.application.present?
  FactoryGirl.find_definitions
  connection_info = YAML.load_file('config/database.yml').fetch('test')
  ActiveRecord::Base.establish_connection(connection_info)

  # Runs rake db:test:prepare before test run
  if ActiveRecord::Migrator.needs_migration?
    require_relative '../config/application'
    ActiveRecord::Base.maintain_test_schema = true
    ActiveRecord::Migration.maintain_test_schema!
  end
end
