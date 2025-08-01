class Product < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true
end
