# Represents a hospital entity fetched from Socrata's API.
class Hospital < ActiveRecord::Base
  validates :provider_id, uniqueness: true
  belongs_to :hospital_system

  def self.create_or_update(attributes)
    find_or_initialize_by(provider_id: attributes.fetch('provider_id'))
      .update_attributes!(attributes)
  end
end
