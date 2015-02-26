# .
module DimensionSamplesGetter
  # Allows specification of required dimension samples in the public charts tree
  SingleMeasure = Struct.new(:dataset_id, :column_name) do
    def initialize(dataset_id:, column_name:)
      super(dataset_id, column_name)
    end

    def data(providers)
      DimensionSample::SingleMeasure.data(
        column_name: column_name,
        dataset_id: dataset_id,
        providers: providers,
      )
    end
  end
end
