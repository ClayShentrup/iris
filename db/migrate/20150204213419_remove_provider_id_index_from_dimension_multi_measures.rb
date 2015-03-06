class RemoveProviderIdIndexFromDimensionMultiMeasures < ActiveRecord::Migration
  def up
    remove_index :dimension_multi_measures, :socrata_provider_id
  end

  def down
    add_index :dimension_multi_measures, :socrata_provider_id
  end
end
