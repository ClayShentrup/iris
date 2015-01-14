class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.column :name, :string
    end
  end
end
