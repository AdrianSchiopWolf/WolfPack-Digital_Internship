# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :decimal(, )
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Product < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true

  has_many :cart_items, dependent: :destroy, class_name: 'Cart'
  has_many :users, dependent: :destroy, through: :cart_items
  has_many :order_items, dependent: :destroy
end
