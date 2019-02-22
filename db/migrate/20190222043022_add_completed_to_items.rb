class AddCompletedToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :completed, :boolean, default: false
    Item.where(completed: nil).update_all(completed: false)
  end
end
