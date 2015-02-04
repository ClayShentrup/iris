class AddNullConstraintsToDimensionSampleMultiMeasures < ActiveRecord::Migration
  def change
    change_column_null(:dimension_sample_multi_measures, :provider_id, false)
    change_column_null(:dimension_sample_multi_measures, :measure_id, false)
    change_column_null(:dimension_sample_multi_measures, :column_name, false)
    change_column_null(:dimension_sample_multi_measures, :value, false)
  end
end
