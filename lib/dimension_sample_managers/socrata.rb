# .
module DimensionSampleManagers
  # Satisfies the DimensionSampleManager interface to retrieve and refresh data.
  Socrata = Struct.new(:dataset, :options) do
    def initialize(dataset:, options:)
      super(dataset, options)
    end

    def data(providers)
      data_getter_class.call(
        dataset_id: dataset_id,
        providers: providers,
        options: options,
      )
    end

    private

    def data_getter_class
      data_getter_class_name.constantize
    end

    def data_getter_class_name
      "Socrata::DimensionSampleGetters::#{dataset_type}"
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
