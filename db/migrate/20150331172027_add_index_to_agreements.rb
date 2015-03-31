class AddIndexToAgreements < ActiveRecord::Migration
  def change
    add_index(
      :agreements,
      [:item_id, :item_type, :user_id],
      unique: true,
    )
    add_index(
      :agreements,
      [:item_id, :item_type],
    )
    remove_index(:agreements, column: :item_type)
    remove_index(:agreements, column: :item_id)
  end
end
