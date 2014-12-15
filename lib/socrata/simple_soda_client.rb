require 'soda'
require 'active_support/core_ext/object/try'

module Socrata
  # A facade to simplify working with Socrata.
  #   - Hardcodes the domain and page size ("limit")
  #   - Provides pagination functionality
  class SimpleSodaClient
    DOMAIN = 'data.medicare.gov'
    PAGE_SIZE = 1000

    def initialize(dataset_id: fail, required_fields: fail)
      @dataset_id = dataset_id
      @required_fields = required_fields
    end

    def get(page: fail)
      @most_recent_result = client.get(
        @dataset_id,
        '$limit' => PAGE_SIZE,
        '$SELECT' => @required_fields.join(','),
        '$offset' => offset_for_page(page),
      )
    end

    def possible_next_page?
      we_have_not_gotten_any_results_yet? or
        @most_recent_result.size == PAGE_SIZE
    end

    private

    def we_have_not_gotten_any_results_yet?
      !@most_recent_result
    end

    def client
      @client ||= ::SODA::Client.new(domain: DOMAIN)
    end

    def offset_for_page(page)
      (page - 1) * PAGE_SIZE
    end
  end
end
