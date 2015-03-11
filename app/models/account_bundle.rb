require './app/models/provider'

# Associate bundles to accounts
class AccountBundle < ActiveRecord::Base
  belongs_to :accounts
end
