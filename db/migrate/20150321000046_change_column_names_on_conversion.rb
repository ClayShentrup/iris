class ChangeColumnNamesOnConversion < ActiveRecord::Migration
  def change
    rename_column :conversations, :node_component_id, :node_id_component
    rename_column :conversations, :user_id, :author_id
  end
end
