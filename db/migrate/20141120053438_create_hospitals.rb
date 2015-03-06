# Initial creation to support the Hospital model
class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.column :name, :string
      t.column :zip_code, :integer
      t.column :hospital_type, :string
      t.column :provider_id, :string
      t.column :state, :string
      t.column :city, :string
    end
  end
end
