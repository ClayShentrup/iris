module HospitalsImporter
  DATASET_ID = "xubh-q36u"
  REQUIRED_FIELDS = %w[
    provider_id
    hospital_name
    hospital_type
    city
    state
    zip_code
  ]

  def self.perform
    client = HospitalsImporter::SimpleSodaClient.new(
      dataset_id: DATASET_ID,
      required_fields: REQUIRED_FIELDS
    )

    page = 1

    total_rows = 0

    while true
      response = client.get(page: page)

      break unless cliet.possible_next_page?

      response.each do |row|
        Hospital.from_hashie_mash(row)
      end

      page += 1
      total_rows += response.count
    end

    puts "\nWent through #{total_rows} hospitals"
  end
end
