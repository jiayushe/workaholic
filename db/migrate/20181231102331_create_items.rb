class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :details
      t.date :deadline
      t.integer :level_of_importance

      t.timestamps
    end
  end
end
