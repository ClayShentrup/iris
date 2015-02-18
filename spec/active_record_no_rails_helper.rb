require 'active_record_helper'

unless defined?(Rails)
  database_yml = File.read('config/database.yml')
  database_yml_erb_parsed = ERB.new(database_yml).result
  connection_info = YAML.load(database_yml_erb_parsed).fetch('test')
  ActiveRecord::Base.establish_connection(connection_info)
  if ActiveRecord::Migrator.needs_migration?
    require_relative '../config/application'
    maintain_test_schema
  end
end
