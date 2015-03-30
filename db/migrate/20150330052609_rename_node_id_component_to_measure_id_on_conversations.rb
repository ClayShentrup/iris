class RenameNodeIdComponentToMeasureIdOnConversations < ActiveRecord::Migration
  def change
    rename_column :conversations, :node_id_component, :measure_id
  end
end
