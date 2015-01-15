class AddIndexToHospitalSystems < ActiveRecord::Migration
  def change
    add_index(:hospital_systems, :name)
  end
end
