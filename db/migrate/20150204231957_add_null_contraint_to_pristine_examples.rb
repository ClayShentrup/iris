class AddNullContraintToPristineExamples < ActiveRecord::Migration
  def change
    change_column_null(:pristine_examples, :name, false)
    change_column_null(:pristine_examples, :description, false)
  end
end
