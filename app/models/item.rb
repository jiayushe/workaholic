class Item < ApplicationRecord
  has_many :remarks, dependent: :destroy
  validates :title, presence: true
  validates :deadline, presence: true
end
