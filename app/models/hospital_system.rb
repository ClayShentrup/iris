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

  def self.create_or_update(attributes)
    find_or_initialize_by(name: attributes.fetch('name'))
      .update_attributes!(attributes)
  end
end
