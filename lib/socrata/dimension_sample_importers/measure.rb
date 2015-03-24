require 'socrata/simple_soda_client_for_measures'
require 'active_support/core_ext/string/exclude'
require './app/models/dimension_sample/multi_measure'

module DimensionSampleManagers
  # .
  module DimensionSampleRefreshers
    # Fetches Socrata data and creates or updates single-measure dimension
    # samples in our database.
    MultiMeasure = Struct.new(:column_name, :dataset_id, :measure_id) do
      def self.call(column_name:, dataset_id:, measure_id:)
        new(column_name, dataset_id, measure_id).call
      end

      def call
        processed_dimension_samples.each do |dimension_sample_attributes|
          DimensionSample::MultiMeasure
          .create_or_update!(dimension_sample_attributes)
        end
      end

      private

      def processed_dimension_samples
        available_dimension_samples.map do |dimension_sample|
          {
            column_name: column_name,
            dataset_id: dataset_id,
            measure_id: measure_id,
            socrata_provider_id: dimension_sample.fetch('provider_id'),
            value: dimension_sample.delete(column_name),
          }
        end
      end

      def available_dimension_samples
        dimension_samples.select do |dimension_sample|
          dimension_sample.key?(column_name) and
          dimension_sample.fetch(column_name).exclude?('Not Available')
        end
      end

      def dimension_samples
        SimpleSodaClientForMeasures.call(
          measure_id: measure_id,
          dataset_id: dataset_id,
          required_columns: required_columns,
        )
      end

      def required_columns
        [
          :measure_id,
          :provider_id,
          column_name,
        ]
      end
    end
  end
end
