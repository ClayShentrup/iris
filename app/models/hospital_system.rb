# == Schema Information
#
# Table name: hospital_systems
#
#  id   :integer          not null, primary key
#  name :string           not null
#

# Represents a system entity
class HospitalSystem < ActiveRecord::Base
  validates :name, presence: true
  has_many :hospitals
  has_one :account, as: :virtual_system

  delegate :count, to: :hospitals, prefix: true
end
