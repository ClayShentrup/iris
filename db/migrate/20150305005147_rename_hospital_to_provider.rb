class RenameHospitalToProvider < ActiveRecord::Migration
  def change
    rename_table :hospitals, :providers
  end
end
