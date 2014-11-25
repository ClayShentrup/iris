class Hospital < ActiveRecord::Base
  validates_uniqueness_of :provider_id

  def self.from_hashie_mash(row)
    hospital = find_or_initialize_by(provider_id: row.provider_id)

    hospital.tap do |h|
      h.name = row.hospital_name
      h.zip_code = row.zip_code
      h.hospital_type = row.hospital_type
      h.provider_id = row.provider_id
      h.state = row.state
      h.city = row.city
    end

    hospital.save if hospital.changed?
  end

  def self.search(query)
    where('LOWER(name) LIKE LOWER(:query)', query: "%#{query}%")
  end
end
