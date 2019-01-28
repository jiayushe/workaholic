class Item < ApplicationRecord
  has_many :remarks, dependent: :destroy
  has_many :item_categories
  has_many :categories, through: :item_categories
  belongs_to :user
  validates :title, presence: true, uniqueness: true
# validates :deadline, presence: true
  validates :level_of_importance, 
	     numericality: { only_integer: true, 
		             greater_than: 0, 
			     less_than: 6, 
			     message: "(priority) must be between 1 and 5 inclusive" }

  def self.search(keyword)
    self.where("title LIKE ?", "%#{keyword}%")
  end  

  def assign_categories(input_categories, user)
    existing = categories.all.map { |c| c.name }
    input = input_categories.split(",")
    to_add = input - existing
    to_rm = existing - input

    to_add.each do |c|
      category = user.categories.find_or_create_by!(name: c)
      category.save
      item_categories.create!(item: self, category: category)
    end

    to_rm.each do |c|
      category = user.categories.find_by(name: c)
      item_categories.find_by(item: self, category: category).destroy
    end
  end
end
