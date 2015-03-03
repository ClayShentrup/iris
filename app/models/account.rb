# == Schema Information
#
# Table name: accounts
#
#  id                  :integer          not null, primary key
#  default_hospital_id :integer          not null
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
  belongs_to :default_hospital, class_name: 'Hospital'
  has_many :users

  attr_accessor :virtual_system_gid

  delegate :name,
           to: :virtual_system
  delegate :name,
           to: :default_hospital, prefix: true

  validates :default_hospital, presence: true
  validates :virtual_system, presence: true
end
