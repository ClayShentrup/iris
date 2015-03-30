class AddDataIndexesToDimensionSampleMeasures < ActiveRecord::Migration
  def change
    add_index(
      :dimension_sample_measures,
      [:socrata_provider_id, :measure_id],
      name: 'index_dimension_sample_measures_on_provider_id_and_measure_id',
      unique: true,
    )
  end
end
