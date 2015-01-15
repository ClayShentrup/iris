class AddHospitalSystemColumnToHospital < ActiveRecord::Migration
  def change
    add_column :hospitals, :hospital_system_id, :integer
    add_index :hospitals, :hospital_system_id
  end
end
