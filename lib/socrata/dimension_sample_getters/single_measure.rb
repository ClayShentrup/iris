# .
module Socrata
  module DimensionSampleGetters
    # Allows specification of required dimension samples in the public charts
    # tree
    module SingleMeasure
      def self.call(dataset_id:, providers:, options:)
        DimensionSample::SingleMeasure.data(
          column_name: options.fetch(:column_name),
          dataset_id: dataset_id,
          providers: providers,
        )
      end
    end
  end
end
