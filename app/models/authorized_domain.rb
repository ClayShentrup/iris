require './app/models/account'

# Authorized domains for a given account.
class AuthorizedDomain < ActiveRecord::Base
  belongs_to :account

  validates :name, presence: true
  validates :account, presence: true
end
