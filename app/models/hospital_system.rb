# == Schema Information
#
# Table name: hospital_systems
#
#  id   :integer          not null, primary key
#  name :string           not null
#
require './app/models/provider'
require './app/models/account'

# Represents a system entity
class HospitalSystem < ActiveRecord::Base
  validates :name, presence: true
  has_many :providers
  has_one :account, as: :virtual_system

  delegate :count, to: :providers, prefix: true
end
