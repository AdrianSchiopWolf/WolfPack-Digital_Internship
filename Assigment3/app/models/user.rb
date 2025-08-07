class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password validations: { presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}\z/, message: "must include at least one lowercase letter, one uppercase letter, and one digit" } }
  has_many :products, dependent: :destroy, through: :cart_items
  has_many :cart_items, dependent: :destroy, class_name: 'Cart'

  enum role: { user: 0, admin: 1 }
end
