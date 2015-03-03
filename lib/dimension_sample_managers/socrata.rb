require 'socrata/dimension_sample_refreshers/single_measure'
# .
module DimensionSampleManagers
  # Satisfies the DimensionSampleManager interface to retrieve and refresh data.
  Socrata = Struct.new(:dataset, :options) do
    def initialize(dataset:, options:)
      super(dataset, options)
    end

    def data(providers)
      dimension_sample_model_class.data(
        dataset_id: dataset_id,
        providers: providers,
        options: options,
      )
    end

    def refresh
      data_refresher_class.call(
        dataset_id: dataset_id,
        options: options,
        provider_id_column_name: provider_id_column_name,
      )
    end

    private

    def provider_id_column_name
      dataset_class.const_get('PROVIDER_ID_COLUMN_NAME').to_s
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

    def dataset_id
      dataset_class.const_get('DATASET_ID')
    end

    def dataset_type
      dataset_class.const_get('DATASET_TYPE')
    end

    def dataset_class
      "Socrata::Datasets::#{dataset}".constantize
    end
  end
end
