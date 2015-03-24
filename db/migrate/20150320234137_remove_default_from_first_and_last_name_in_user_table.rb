class RemoveDefaultFromFirstAndLastNameInUserTable < ActiveRecord::Migration
  def change
    change_column_default :users, :first_name, nil
    change_column_default :users, :last_name, nil
  end
end
