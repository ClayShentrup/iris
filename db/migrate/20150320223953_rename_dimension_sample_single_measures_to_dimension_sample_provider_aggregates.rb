class RenameDimensionSampleSingleMeasuresToDimensionSampleProviderAggregates < ActiveRecord::Migration
  def change
    rename_table :dimension_sample_single_measures, :dimension_sample_provider_aggregates
  end
end
