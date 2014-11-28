require_relative 'simple_soda_client'

module Socrata
  class ResultIterator
    include Enumerable
    attr_reader :length

    def initialize(dataset_id: fail, required_fields: fail)
      @dataset_id = dataset_id
      @required_fields = required_fields
    end

    def each(&block)
      @length = 0
      page = 1
      begin
        page_of_results = client.get(page: page)
        @length += page_of_results.length
        page_of_results.map do |hashie|
          hashie.to_hash.tap do |result|
            result['name'] = result.delete('hospital_name')
          end
        end
        .each(&block)
        page += 1
      end while client.possible_next_page?
    end

    private

    def client
      @client ||= SimpleSodaClient.new(
        dataset_id: @dataset_id,
        required_fields: @required_fields
      )
    end
  end
end
