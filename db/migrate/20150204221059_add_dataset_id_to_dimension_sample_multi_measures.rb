class AddDatasetIdToDimensionSampleMultiMeasures < ActiveRecord::Migration
  def change
    add_column :dimension_sample_multi_measures, :dataset_id, :string
  end
end
