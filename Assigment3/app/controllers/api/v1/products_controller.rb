module Api
  module V1
    class ProductsController < Api::V1::BaseController
      def index
        products = Product.all
        render json: Alba.serialize(products, with: ProductSerializer), status: :ok
      end
    end
  end
end