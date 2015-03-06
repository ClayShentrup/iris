class AddNullConstraintsToHospitals < ActiveRecord::Migration
  def change
    change_column_null(:hospitals, :name, false)
    change_column_null(:hospitals, :zip_code, false)
    change_column_null(:hospitals, :hospital_type, false)
    change_column_null(:hospitals, :provider_id, false)
    change_column_null(:hospitals, :state, false)
    change_column_null(:hospitals, :city, false)
  end
end
