class AddSystemColumnToHospital < ActiveRecord::Migration
  def change
    add_column :hospitals, :system_id, :integer
  end
end
