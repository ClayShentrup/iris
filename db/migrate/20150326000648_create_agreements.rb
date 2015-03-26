class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.integer :item_id
      t.string  :item_type
      t.integer :user_id
      t.timestamps null: false
    end

    add_index :agreements, :item_id
    add_index :agreements, :item_type
    add_index :agreements, :user_id
  end
end
