module Socrata
  # We need to import CMS hospital data from Socrata. This is the core wrapper
  # for the involved components.
  module CreateOrUpdateHospitals
    DATASET_ID = 'xubh-q36u'
    REQUIRED_FIELDS = %w[
      provider_id
      hospital_name
      hospital_type
      city
      state
      zip_code
    ]

    def self.call
      hospitals = ResultIterator.new(
        dataset_id: DATASET_ID,
        required_fields: REQUIRED_FIELDS,
      )
      hospitals.each do |hospital_attributes|
        Hospital.create_or_update(hospital_attributes)
      end
      hospitals.length
    end
  end
end
