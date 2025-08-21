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
class ProductSerializer < ApplicationSerializer
  attributes :id, :name, :price, :category
  attribute :photo_url do |product|
    Rails.application.routes.url_helpers.url_for(product.photo) if product.photo.attached?
  end
end
