# == Schema Information
#
# Table name: authorized_domains
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require './app/models/account'
require './app/validators/domain_name_validator'

# Authorized domains for a given account.
class AuthorizedDomain < ActiveRecord::Base
  belongs_to :account

  validates :name, presence: true, domain_name: true
  validates :account, presence: true,
                      unless: :skip_association_presence_validations

  attr_accessor :skip_association_presence_validations
end
