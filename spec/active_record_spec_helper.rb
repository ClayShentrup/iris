unless defined? ActiveRecord
  require 'active_record'
  connection_info = YAML.load_file('config/database.yml').fetch('test')
  ActiveRecord::Base.establish_connection(connection_info)
end

cleanup_already_handled = defined?(Rails)
unless cleanup_already_handled
  RSpec.configure do |config|
    config.around do |example|
      ActiveRecord::Base.transaction do
        example.run
        fail ActiveRecord::Rollback
      end
    end
  end
end

require 'rails_common_spec_helper'
