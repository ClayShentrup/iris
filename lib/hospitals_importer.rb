module HospitalsImporter
  DATASET_ID = "xubh-q36u"

  def self.perform
    client = HospitalsImporter::SimpleSodoaClient.new(dataset_id: DATASET_ID)
    counter = 0

    total_rows = 0

    while true
      response = client.get(offset: counter * PAGE_SIZE)

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
