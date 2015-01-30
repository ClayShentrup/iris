require 'soda'
require 'active_support/core_ext/object/try'

module Socrata
  # A facade to simplify working with Socrata.
  #   - Hardcodes the domain and page size ("limit")
  #   - Provides pagination functionality
  class SimpleSodaClient
    DOMAIN = 'data.medicare.gov'
    PAGE_SIZE = 1000

    def initialize(dataset_id:, required_columns:, row_filter:)
      @dataset_id = dataset_id
      @required_columns = required_columns
      @row_filter = row_filter
    end

    def get(page:)
      @most_recent_result = convert_hashie_objects_to_hashes(
        results_for_offset(offset_for_page(page)),
      )
    end

    def possible_next_page?
      we_have_not_gotten_any_results_yet? or
        @most_recent_result.size == PAGE_SIZE
    end

    private

    def convert_hashie_objects_to_hashes(array_of_hashie_objects)
      array_of_hashie_objects.map(&:to_hash)
    end

    def results_for_offset(offset)
      client.get(
        @dataset_id,
        '$limit' => PAGE_SIZE,
        '$select' => @required_columns.join(','),
        '$offset' => offset,
        '$where' => where,
      )
    end

    def we_have_not_gotten_any_results_yet?
      !@most_recent_result
    end

    def client
      @client ||= ::SODA::Client.new(domain: DOMAIN)
    end

    def offset_for_page(page_with_one_based_index)
      page_with_zero_based_index = page_with_one_based_index - 1
      page_with_zero_based_index * PAGE_SIZE
    end

    def where
      return '' unless @row_filter
      "#{@row_filter.fetch(:column_name)} = '#{@row_filter.fetch(:value)}'"
    end
  end
end
