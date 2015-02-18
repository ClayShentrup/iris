# If this test fails, it means you should remove the hack in database_cleaner.
# See this comment for background:
# github.com/DatabaseCleaner/database_cleaner/issues/317#issuecomment-70417037
require 'active_record_no_rails_helper'

RSpec.describe 'database cleaner' do
  it 'blows away the schema migrations table' do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    error_message = 'Congratulations, the bug has been fixed. Now go remove ' \
      'that awful hack.'
    expect(ActiveRecord::Migrator.current_version).to eq(0), error_message
  end
end
