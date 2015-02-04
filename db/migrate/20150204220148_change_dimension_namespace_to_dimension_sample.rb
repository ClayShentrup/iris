class ChangeDimensionNamespaceToDimensionSample < ActiveRecord::Migration
  def change
    rename_table :dimension_multi_measures, :dimension_sample_multi_measures
    rename_table :dimension_single_measures, :dimension_sample_single_measures
  end
end
