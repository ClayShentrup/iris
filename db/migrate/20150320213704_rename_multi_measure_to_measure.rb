class RenameMultiMeasureToMeasure < ActiveRecord::Migration
  def change
    rename_table :dimension_sample_multi_measures, :dimension_sample_measures
  end
end
