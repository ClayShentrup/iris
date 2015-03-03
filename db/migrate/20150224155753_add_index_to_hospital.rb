class AddIndexToHospital < ActiveRecord::Migration
  def change
    add_index :hospitals, [:city, :state]
    add_index :hospitals, :state
  end
end
