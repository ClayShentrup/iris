class RenameAccountsDefaultHospitalIdToDefaultProviderId < ActiveRecord::Migration
  def change
    rename_column :accounts, :default_hospital_id, :default_provider_id
  end
end
