class CreatePristineExamples < ActiveRecord::Migration
  def change
    create_table :pristine_examples do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
