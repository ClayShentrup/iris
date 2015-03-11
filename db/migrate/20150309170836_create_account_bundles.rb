class CreateAccountBundles < ActiveRecord::Migration
  def change
    create_table :account_bundles do |t|
      t.integer :account_id
      t.string :bundle_id
    end

    add_index :account_bundles, :account_id
  end
end
