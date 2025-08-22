# frozen_string_literal: true

class OrderItemSerializer
  include Alba::Resource

  attributes :id, :quantity, :price_at_purchase

  attribute :product do |object|
    {
      id: object.product.id,
      name: object.product.name,
      price: object.product.price,
      image_url: object.product.photo.attached? ? Rails.application.routes.url_helpers.rails_blob_url(object.product.photo, only_path: true) : nil
    }
  end
end
