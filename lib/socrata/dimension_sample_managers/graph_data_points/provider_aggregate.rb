require './app/models/dimension_sample/provider_aggregate'
require_relative '../../dimension_sample_importer'
require_relative '../../simple_soda_client'
require './app/jobs/dimension_sample_manager_import_job'

# .
module Socrata
  module DimensionSampleManagers
    # Satisfies the DimensionSampleManager interface to retrieve and refresh
    # data.
    module GraphDataPoints
      ProviderAggregate = Struct.new(:value_column_name, :dataset_id) do
        def initialize(value_column_name:, dataset_id:)
          super(value_column_name, dataset_id)
        end

        def data(providers)
          DimensionSample::ProviderAggregate.data(
            base_options.merge(
              column_name: value_column_name,
              providers: providers,
            ),
          )
        end

        def import
          DimensionSampleManagerImportJob.perform_later(
            dimension_samples: dimension_samples,
            model_attributes: base_options.merge(
              column_name: value_column_name.to_s,
            ),
            model_class_string: 'DimensionSample::ProviderAggregate',
            rename_hash: {},
            value_column_name: value_column_name.to_s,
          )
        end

        def subtitle
        end

        private

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

        def base_options
          { dataset_id: dataset_id }
        end
      end
    end
  end
end
