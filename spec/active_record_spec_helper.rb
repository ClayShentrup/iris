require 'rails_common_spec_helper'

running_tests_which_load_rails = ActiveRecord::Base.connected?
unless running_tests_which_load_rails
  FactoryGirl.find_definitions
  connection_info = YAML.load_file('config/database.yml').fetch('test')
  ActiveRecord::Base.establish_connection(connection_info)
end
