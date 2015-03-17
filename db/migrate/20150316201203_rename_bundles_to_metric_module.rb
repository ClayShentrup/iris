class RenameBundlesToMetricModule < ActiveRecord::Migration
  def change
    rename_column :purchased_metric_modules, :bundle_id, :metric_module_id
  end
end
