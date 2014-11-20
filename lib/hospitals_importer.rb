module HospitalsImporter
  DOMAIN = "data.medicare.gov"
  DATASET_ID = "xubh-q36u"
  PAGE_SIZE = 1000

  def self.perform
    client = SODA::Client.new(domain: DOMAIN)
    counter = 0

    total_rows = 0

    while true
      response = client.get DATASET_ID, {"$limit" => PAGE_SIZE, "$offset" => counter * PAGE_SIZE}

      break if response.size == 0

      response.each do |row|
        Hospital.from_hashie_mash(row)
      end

      counter += 1
      total_rows += response.count
    end

    puts "\nWent through #{total_rows} hospitals"
  end
end