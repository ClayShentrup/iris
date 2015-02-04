class ChangeDimensionMultimeasuresToDimensionMultiMeasures < ActiveRecord::Migration
  def change
    rename_table :dimension_multimeasures, :dimension_multi_measures
  end
end
