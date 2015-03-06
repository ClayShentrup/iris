class AddNullConstraintsToDimensionSampleSingleMeasures < ActiveRecord::Migration
  def change
    change_column_null(:dimension_sample_single_measures, :dataset_id, false)
    change_column_null(:dimension_sample_single_measures, :provider_id, false)
    change_column_null(:dimension_sample_single_measures, :column_name, false)
    change_column_null(:dimension_sample_single_measures, :value, false)
  end
end
