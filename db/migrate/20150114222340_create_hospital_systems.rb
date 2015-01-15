class CreateHospitalSystems < ActiveRecord::Migration
  def change
    create_table :hospital_systems do |t|
      t.column :name, :string
    end
  end
end
