class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :provider_id
      t.integer :user_id
      t.string :node_component_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.timestamps null: false
    end
    add_index :conversations, [:node_component_id, :provider_id, :user_id],
              name: 'index_conversations'
  end
end
