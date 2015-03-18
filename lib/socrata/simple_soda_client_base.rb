require 'soda'
require 'active_support/core_ext/object/try'

module Socrata
  # A facade to simplify working with Socrata.
  #   - Hardcodes the domain and page size ("limit")
  #   - Provides pagination functionality
  class SimpleSodaClientBase
    include Enumerable

    DOMAIN = 'data.medicare.gov'
    PAGE_SIZE = 1000

    def initialize(dataset_id:, required_columns:, extra_query_options:)
      @dataset_id = dataset_id
      @required_columns = required_columns
      @extra_query_options = extra_query_options
      @length = 0
    end

    def each(&block)
      loop do
        next_page_of_results.each(&block)
        @length += page_length
        break unless possible_next_page?
      end
    end

    private

    def possible_next_page?
      page_length == PAGE_SIZE
    end

    def page_length
      @page.length
    end

    def next_page_of_results
      @page = next_page_of_socrata_results.map(&:to_h)
    end

    def next_page_of_socrata_results
      client.get(@dataset_id, soda_client_options)
    end

    def soda_client_options
      @extra_query_options.merge(
        '$limit' => PAGE_SIZE,
        '$select' => @required_columns.join(','),
        '$offset' => @length,
      )
    end

    def client
      @client ||= ::SODA::Client.new(domain: DOMAIN)
    end
  end
end
