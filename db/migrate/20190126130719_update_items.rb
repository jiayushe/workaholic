class UpdateItems < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.belongs_to :user
    end
  end
end
