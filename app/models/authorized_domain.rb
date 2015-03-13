require './app/models/account'
require 'public_suffix'
require './app/validators/domain_name_validator'

# Authorized domains for a given account.
class AuthorizedDomain < ActiveRecord::Base
  belongs_to :account

  validates :name,
            presence: true,
            domain_name: true
  validates :account, presence: true
end
