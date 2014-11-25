require 'soda'

module HospitalsImporter
  class SimpleSodaClient
    DOMAIN = 'data.medicare.gov'
    PAGE_SIZE = 1000
    REQUIRED_FIELDS = %w[
      provider_id
      hospital_name
      hospital_type
      city
      state
      zip_code
    ]

    def initialize(dataset_id: fail)
      @dataset_id = dataset_id
    end

    def get(offset: fail)
      client.get(
        @dataset_id,
        {
          '$limit' => PAGE_SIZE,
          '$SELECT' => REQUIRED_FIELDS.join(','),
          '$offset' => offset
        }
      )
    end

    private

    def client
      @client ||= SODA::Client.new(domain: DOMAIN)
    end
  end
end
