class RemoveColumnNameAndDatasetIdFromDimensionSampleMeasures < ActiveRecord::Migration
  def change
    remove_column :dimension_sample_measures, :column_name
    remove_column :dimension_sample_measures, :dataset_id
  end
end
