class CreateLogLines < ActiveRecord::Migration
  def change
    create_table :log_lines do |t|
      t.string :heroku_request_id, null: false
      t.text :data, null: false
      t.datetime :logged_at, null: false

      t.timestamps null: false
    end
  end
end
