require './app/models/provider'
require 'socrata/dimension_sample_refreshers/provider_aggregate'
require 'socrata/dimension_sample_refreshers/measure'

# .
module DimensionSampleManagers
  # Satisfies the DimensionSampleManager interface to retrieve and refresh data.
  Socrata = Struct.new(:column_name, :dataset_id, :additional_options) do
    def initialize(column_name:, dataset_id:, **additional_options)
      super(column_name, dataset_id, additional_options)
    end

    def data(providers)
      dimension_sample_model_class.data(
        base_options.merge(providers: providers),
      )
    end

    def refresh
      data_refresher_class.call(base_options)
    end

    private

    def base_options
      additional_options.merge(
        column_name: column_name.to_s,
        dataset_id: dataset_id,
      )
    end

    def dimension_sample_model_class
      dimension_sample_model_class_name.constantize
    end

    def dimension_sample_model_class_name
      "DimensionSample::#{dataset_type}"
    end

    def data_refresher_class
      data_refresher_class_name.constantize
    end

    def data_refresher_class_name
      "Socrata::DimensionSampleRefreshers::#{dataset_type}"
    end

    def dataset_type
      dataset_info.fetch(:dataset_type).to_s.camelize
    end

    def dataset_info
      DATASETS.fetch(dataset_id)
    end
  end
end
