class RenameProviderIdFieldToSocrataProviderId < ActiveRecord::Migration
  def change
    rename_column :providers, :provider_id, :socrata_provider_id
    rename_column :dimension_sample_multi_measures, :provider_id, :socrata_provider_id
    rename_column :dimension_sample_single_measures, :provider_id, :socrata_provider_id
  end
end
