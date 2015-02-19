# Do not directly require this in a spec, it is a common dependency of Rails
# and ActiveRecord spec_helpers.
require 'active_record'
require 'rails_common_spec_helper'
require 'factory_girl'
require './spec/support/database_cleaner'

def maintain_test_schema
  ActiveRecord::Base.maintain_test_schema = true
  ActiveRecord::Migration.maintain_test_schema!
end

RSpec.configure do |config|
  FactoryGirl.find_definitions
  config.include(FactoryGirl::Syntax::Methods)
end
