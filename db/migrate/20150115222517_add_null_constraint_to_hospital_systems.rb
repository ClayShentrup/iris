class AddNullConstraintToHospitalSystems < ActiveRecord::Migration
  def change
    change_column_null(:hospital_systems, :name, false)
  end
end
