require 'soda'
require 'active_support/core_ext/object/try'

module Socrata
  # A facade to simplify working with Socrata.
  #   - Hardcodes the domain and page size ("limit")
  #   - Provides pagination functionality
  class SimpleSodaClientBase
    DOMAIN = 'data.medicare.gov'
    PAGE_SIZE = 50_000

    def self.call(*args)
      new(*args).call
    end

    def initialize(dataset_id:, required_columns:, extra_query_options:)
      @dataset_id = dataset_id
      @required_columns = required_columns
      @extra_query_options = extra_query_options
      @results = []
    end

    def call
      loop do
        @results += next_page_of_results
        break unless possible_next_page?
      end
      @results
    end

    private

    def possible_next_page?
      @page.length == PAGE_SIZE
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
        '$offset' => @results.length,
      )
    end

    def client
      @client ||= ::
        SODA::Client.new(
          domain: DOMAIN,
          app_token: ENV.fetch('SOCRATA_APP_TOKEN', ''),
        )
    end
  end
end
