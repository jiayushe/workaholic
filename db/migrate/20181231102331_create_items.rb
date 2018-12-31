class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :details
      t.text :deadline
      t.text :level_of_importance

      t.timestamps
    end
  end
end
