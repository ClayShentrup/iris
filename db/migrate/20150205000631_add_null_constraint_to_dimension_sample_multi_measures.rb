class AddNullConstraintToDimensionSampleMultiMeasures < ActiveRecord::Migration
  def change
    change_column_null(:dimension_sample_multi_measures, :dataset_id, false)
  end
end
