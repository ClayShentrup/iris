class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.column :name, :varchar
      t.column :zip_code, :integer
      t.column :hospital_type, :varchar
      t.column :provider_id, :varchar
      t.column :state, :varchar
      t.column :city, :varchar
    end
  end
end
