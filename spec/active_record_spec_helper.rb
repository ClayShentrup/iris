ENV['RAILS_ENV'] ||= 'test'

unless defined? ActiveRecord
  require 'active_record'
  connection_info = YAML.load_file('config/database.yml').fetch('test')
  ActiveRecord::Base.establish_connection(connection_info)
end

require 'rails_common_spec_helper'
