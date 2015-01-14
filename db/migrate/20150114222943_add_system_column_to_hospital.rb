class AddSystemColumnToHospital < ActiveRecord::Migration
  def change
    add_column :hospitals, :system_id, :integer
    add_index :hospitals, :system_id
  end
end
