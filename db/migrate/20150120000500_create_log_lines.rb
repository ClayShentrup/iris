class CreateLogLines < ActiveRecord::Migration
  def change
    create_table :log_lines do |t|
      t.string :heroku_request_id
      t.text :data
      t.datetime :logged_at

      t.timestamps null: false
    end
  end
end
