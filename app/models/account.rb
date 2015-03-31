# == Schema Information
#
# Table name: accounts
#
#  id                  :integer          not null, primary key
#  default_provider_id :integer
#  virtual_system_id   :integer
#  virtual_system_type :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require './app/models/hospital_system'
require './app/models/user'
require './app/models/authorized_domain'
require './app/models/purchased_metric_module'

# An entity that represents a client account
class Account < ActiveRecord::Base
  belongs_to :virtual_system, polymorphic: true
  belongs_to :default_provider, class_name: :Provider

  has_many :users
  has_many :purchased_metric_modules
  has_many :authorized_domains

  validates :default_provider,
            presence: true,
            unless: :skip_association_presence_validations
  validates :virtual_system,
            presence: true,
            unless: :skip_association_presence_validations

  delegate :name,
           to: :virtual_system,
           prefix: true
  delegate :name,
           to: :default_provider,
           prefix: true

  attr_accessor :virtual_system_gid,
                :skip_association_presence_validations
end
