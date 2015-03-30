class AddSocrataProviderIdIndexToProviders < ActiveRecord::Migration
  def change
    add_index :providers, :socrata_provider_id, unique: true
  end
end
