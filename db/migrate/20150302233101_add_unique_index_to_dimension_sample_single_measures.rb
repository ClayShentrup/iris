class AddUniqueIndexToDimensionSampleSingleMeasures < ActiveRecord::Migration
  def change
    add_index(
      :dimension_sample_single_measures,
      [
        :provider_id,
        :dataset_id,
        :column_name,
      ],
      unique: true,
      name: 'index_dimension_sample_single_measures_unique',
    )
  end
end
