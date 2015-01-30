require_relative 'simple_soda_client'

module Socrata
  # Makes row_filter effectively optional without using optional arguments in
  # the SimpleSodaClient interface (optional args are an anti-pattern)
  module UnfilteredSimpleSodaClient
    def self.new(dataset_id:, required_columns:)
      SimpleSodaClient.new(
        dataset_id: dataset_id,
        required_columns: required_columns,
        row_filter: nil,
      )
    end
  end
end
