class UpdateCompletedInItems < ActiveRecord::Migration[5.2]
  def change
    Item.where(completed: nil).update_all(completed: false)
    change_column_null :items, :completed, false
  end
end
