class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.belongs_to :author, class_name: 'User', null: false, index: true
      t.belongs_to :conversation, null: false, index: true
      t.timestamps null: false
    end
  end
end
