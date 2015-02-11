class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :default_hospital_id, null: false, index: true
      t.references :virtual_system, polymorphic: true, null: false, index: true
      t.timestamps null: false
    end
  end
end
