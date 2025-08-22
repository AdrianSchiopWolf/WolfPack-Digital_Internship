# frozen_string_literal: true

class CartItemSerializer < ApplicationSerializer
  attributes :id, :quantity, :product

  attribute :product do
    {
      id: object.product.id,
      name: object.product.name,
      price: object.product.price,
      image_url: object.product.photo.attached? ? Rails.application.routes.url_helpers.rails_blob_url(object.product.photo, only_path: true) : nil
    }
  end
end
