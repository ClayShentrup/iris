class RenameAccountBundlesToPurchasedMetricModules < ActiveRecord::Migration
  def change
    rename_table :account_bundles, :purchased_metric_modules
  end
end
