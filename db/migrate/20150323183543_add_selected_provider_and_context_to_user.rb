class AddSelectedProviderAndContextToUser < ActiveRecord::Migration
  def change
    add_column :users, :selected_provider_id, :integer, null: true
    add_column :users, :selected_context, :string, null: true
    add_index :users, :selected_provider_id
  end
end
