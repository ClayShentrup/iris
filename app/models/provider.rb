require 'pg_search'
# == Schema Information
#
# Table name: providers
#
#  id                  :integer          not null, primary key
#  name                :string           not null
#  zip_code            :string           not null
#  hospital_type       :string           not null
#  socrata_provider_id :string           not null
#  state               :string           not null
#  city                :string           not null
#  hospital_system_id  :integer
#

# Represents a provider entity fetched from Socrata's API.
class Provider < ActiveRecord::Base
  include PgSearch
  SEARCH_RESULTS_LIMIT = 10

  belongs_to :hospital_system
  has_one :account, as: :virtual_system
  validates :socrata_provider_id, uniqueness: true, presence: true
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

  scope(:in_same_city, lambda do |provider|
    where(city: provider.city, state: provider.state)
  end)

  scope(:in_same_state, ->(provider) { where(state: provider.state) })

  pg_search_scope :search_by_name, against: :name, using: {
    tsearch: { prefix: true },
  }

  def self.create_or_update!(attributes)
    find_or_initialize_by(
      socrata_provider_id: attributes.fetch('socrata_provider_id'),
    ).update_attributes!(attributes)
  end

  def city_and_state
    "#{city}, #{state}"
  end

  def providers
    [self]
  end
end