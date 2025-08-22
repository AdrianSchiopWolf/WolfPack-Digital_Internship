# frozen_string_literal: true

module Api
  module V1
    class ProductsController < Api::V1::BaseController
      # include Api::V1::ProductsControllerDoc

      def index
        products = Product.all
        render json: Alba.serialize(products, with: ProductSerializer), status: :ok
      end
    end
  end
end
