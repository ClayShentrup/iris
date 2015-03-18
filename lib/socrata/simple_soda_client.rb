require 'soda'
require 'active_support/core_ext/object/try'
require_relative './simple_soda_client_base'

module Socrata
  # A facade to simplify working with Socrata.
  #   - Hardcodes the domain and page size ("limit")
  #   - Provides pagination functionality
  class SimpleSodaClient
    def self.new(options)
      SimpleSodaClientBase.new(options.merge(extra_query_options: {}))
    end
  end
end
