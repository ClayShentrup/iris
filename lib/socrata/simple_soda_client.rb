require_relative './simple_soda_client_base'

module Socrata
  # A facade for SimpleSodaClientBase, which provides default arguments
  class SimpleSodaClient
    def self.call(options)
      SimpleSodaClientBase.call(options.merge(extra_query_options: {}))
    end
  end
end
