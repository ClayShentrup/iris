class CreateDimensionSingleMeasures < ActiveRecord::Migration
  def change
    create_table :dimension_single_measures do |t|
      t.string :provider_id
      t.string :dataset_id
      t.string :column_name
      t.string :value

      t.timestamps null: false
    end
  end
end
