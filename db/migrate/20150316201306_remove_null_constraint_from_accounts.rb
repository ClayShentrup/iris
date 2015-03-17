class RemoveNullConstraintFromAccounts < ActiveRecord::Migration
  def change
    change_column_null :accounts, :default_provider_id, true
    change_column_null :accounts, :virtual_system_id, true
    change_column_null :accounts, :virtual_system_type, true
  end
end
