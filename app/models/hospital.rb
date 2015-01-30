# == Schema Information
#
# Table name: hospitals
#
#  id                 :integer          not null, primary key
#  name               :string
#  zip_code           :string
#  hospital_type      :string
#  provider_id        :string
#  state              :string
#  city               :string
#  hospital_system_id :integer
#

# Represents a hospital entity fetched from Socrata's API.
class Hospital < ActiveRecord::Base
  belongs_to :hospital_system
  has_one :account, as: :virtual_system
  validates :provider_id, uniqueness: true, presence: true
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :hospital_type, presence: true

  delegate :name, to: :hospital_system, prefix: true, allow_nil: true

  scope :without_system, -> { where(hospital_system_id: nil) }

  def self.create_or_update(attributes)
    find_or_initialize_by(provider_id: attributes.fetch('provider_id'))
      .update_attributes!(attributes)
  end
end
