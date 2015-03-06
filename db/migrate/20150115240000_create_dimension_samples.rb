class CreateDimensionSamples < ActiveRecord::Migration
  def change
    create_table :dimension_samples do |t|
      t.string :provider_id
      t.string :dimension_identifier
      t.float :value

      t.timestamps null: false
    end

    add_index :dimension_samples,
              [:provider_id, :dimension_identifier],
              unique: true,
              name: 'index_dimension_samples_provider_and_identifier'
  end
end
