class AddNullConstraintToUserEmail < ActiveRecord::Migration
  def change
    change_column_null(:users, :email, false)
  end
end
