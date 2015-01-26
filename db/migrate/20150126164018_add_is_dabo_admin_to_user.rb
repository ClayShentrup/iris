class AddIsDaboAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_dabo_admin, :boolean, null: false, default: false
  end
end
