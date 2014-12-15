require_relative 'simple_soda_client'

module Socrata
  # The SODA client gets one page of results per call. It has no underlying
  # iteration/enumable functionality. This class allows us to iterate through
  # all pages of results and present them as a single "array" of results.
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
      loop do
        page_of_results = client.get(page: page)
        @length += page_of_results.length
        page_of_results.map do |hashie|
          hashie.to_hash.tap do |result|
            result['name'] = result.delete('hospital_name')
          end
        end.each(&block)
        break unless client.possible_next_page?
        page += 1
      end
    end

    private

    def client
      @client ||= SimpleSodaClient.new(
        dataset_id: @dataset_id,
        required_fields: @required_fields,
      )
    end
  end
end
