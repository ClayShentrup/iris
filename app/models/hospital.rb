require 'pg_search'
# == Schema Information
#
# Table name: hospitals
#
#  id                 :integer          not null, primary key
#  name               :string           not null
#  zip_code           :string           not null
#  hospital_type      :string           not null
#  provider_id        :string           not null
#  state              :string           not null
#  city               :string           not null
#  hospital_system_id :integer
#

# Represents a hospital entity fetched from Socrata's API.
class Hospital < ActiveRecord::Base
  include PgSearch
  SEARCH_RESULTS_LIMIT = 10

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

  scope(:search_results, lambda do |term|
    search_by_name(term).limit(SEARCH_RESULTS_LIMIT)
  end)

  scope(:in_same_city, lambda do |hospital|
    where(city: hospital.city, state: hospital.state)
  end)

  scope(:in_same_state, ->(hospital) { where(state: hospital.state) })

  pg_search_scope :search_by_name, against: :name, using: {
    tsearch: { prefix: true },
  }

  def self.create_or_update!(attributes)
    find_or_initialize_by(provider_id: attributes.fetch('provider_id'))
      .update_attributes!(attributes)
  end

  def city_and_state
    "#{city}, #{state}"
  end

  def hospitals
    [self]
  end
end
