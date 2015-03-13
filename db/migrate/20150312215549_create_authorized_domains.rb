class CreateAuthorizedDomains < ActiveRecord::Migration
  def change
    create_table :authorized_domains do |t|
      t.string :name
      t.references :account, index: true

      t.timestamps null: false
    end
  end
end
