class User < ApplicationRecord
  before_save { email.downcase! }
  VALID_EMAIL_ADDRESS = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: VALID_EMAIL_ADDRESS, on: :create }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, if: :password

  has_many :items, dependent: :destroy
  has_many :categories, dependent: :destroy
end
