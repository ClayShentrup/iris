class CreateDimensionMultimeasures < ActiveRecord::Migration
  def change
    create_table :dimension_multimeasures do |t|
      t.string :provider_id, index: true
      t.string :measure_id
      t.string :column_name
      t.string :value

      t.timestamps null: false
    end
  end
end
