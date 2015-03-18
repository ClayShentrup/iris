require 'socrata/simple_soda_client'
require 'active_support/core_ext/string/exclude'

module Socrata
  # .
  module DimensionSampleRefreshers
    # Fetches Socrata data and creates or updates single-measure dimension
    # samples in our database.
    SingleMeasure = Struct.new(:dataset_id,
                               :options) do
      def self.call(dataset_id:, options:)
        new(dataset_id, options).call
      end

      def call
        processed_dimension_samples.each do |dimension_sample_attributes|
          DimensionSample::SingleMeasure
          .create_or_update!(dimension_sample_attributes)
        end
      end

      private

      def processed_dimension_samples
        available_dimension_samples.map do |dimension_sample|
          {
            column_name: value_column_name,
            dataset_id: dataset_id,
            socrata_provider_id: dimension_sample.fetch('provider_id'),
            value: dimension_sample.fetch(value_column_name),
          }
        end
      end

      def available_dimension_samples
        dimension_samples.select do |dimension_sample|
          dimension_sample.key?(value_column_name) and
          dimension_sample.fetch(value_column_name).exclude?('Not Available')
        end
      end

      def dimension_samples
        SimpleSodaClient.call(
          dataset_id: dataset_id,
          required_columns: required_columns,
        )
      end

      def required_columns
        [
          :provider_id,
          value_column_name,
        ]
      end

      def value_column_name
        options.fetch(:column_name).to_s
      end
    end
  end
end
