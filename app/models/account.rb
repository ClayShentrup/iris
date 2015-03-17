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
require './app/models/authorized_domain'

# An entity that represents a client account
class Account < ActiveRecord::Base
  belongs_to :virtual_system, polymorphic: true
  belongs_to :default_provider, class_name: :Provider

  has_many :users
  has_many :purchased_metric_modules
  has_many :authorized_domains

  validates :default_provider,
            presence: true,
            unless: :skip_association_validations
  validates :virtual_system,
            presence: true,
            unless: :skip_association_validations

  delegate :name,
           to: :virtual_system,
           prefix: true
  delegate :name,
           to: :default_provider,
           prefix: true

  attr_accessor :virtual_system_gid,
                :skip_association_validations
end
