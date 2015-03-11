# == Schema Information
#
# Table name: accounts
#
#  id                  :integer          not null, primary key
#  default_provider_id :integer          not null
#  virtual_system_id   :integer          not null
#  virtual_system_type :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require './app/models/hospital_system'
require './app/models/user'

# An entity that represents a client account
class Account < ActiveRecord::Base
  belongs_to :virtual_system, polymorphic: true
  belongs_to :default_provider, class_name: 'Provider'
  has_many :users
  has_many :bundles, class_name: 'AccountBundle'

  attr_accessor :virtual_system_gid

  delegate :name,
           to: :virtual_system
  delegate :name,
           to: :default_provider, prefix: true

  validates :default_provider, presence: true
  validates :virtual_system, presence: true
end
