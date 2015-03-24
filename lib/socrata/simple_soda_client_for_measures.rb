require_relative './simple_soda_client_base'

module Socrata
  # A facade to simplify working with Socrata.
  #   - Hardcodes the domain and page size ("limit")
  #   - Provides pagination functionality
  class SimpleSodaClientForMeasures
    def self.call(measure_id_column_name:, measure_id:, **options)
      SimpleSodaClientBase.call(
        options.merge(
          extra_query_options: {
            '$where' => "#{measure_id_column_name} = '#{measure_id}'",
          },
        ),
      )
    end
  end
end
