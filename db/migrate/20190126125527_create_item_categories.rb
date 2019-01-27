class CreateItemCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :item_categories do |t|
      t.belongs_to :item, null: false, index: true
      t.belongs_to :category, null: false, index: true

      t.timestamps
    end
  end
end
