class DropDimensionSamples < ActiveRecord::Migration
  def change
    drop_table :dimension_samples
  end
end
