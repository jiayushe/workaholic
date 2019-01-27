class Category < ApplicationRecord
  has_many :item_categories
  has_many :items, through: :item_categories
  belongs_to :user
  validates :name, uniqueness: true, presence: true
 
  def self.search(keyword)
    self.where("name LIKE ?", "%#{keyword}%")
  end
 
  def assign_items(input_items, user)
    existing = items.all.map { |t| t.title }
    input = input_items.split(",")
    to_add = input - existing
    to_rm = existing - input

    to_add.each do |t|
	    item = user.items.find_by(title: t) || user.items.create!(title: t, level_of_importance: 1)
      item.save
      item_categories.create!(item: item, category: self)
    end

    to_rm.each do |t|
      item = user.items.find_by(title: t)
      item_categories.find_by(item: item, category: self).destroy
    end
  end
end
