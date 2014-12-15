# Zipcodes should be strings
class ChangeHospitalZipCodeFromIntToString < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :hospitals do |t|
        dir.up   { t.change :zip_code, :string }
        dir.down { t.change :zip_code, :integer }
      end
    end
  end
end
