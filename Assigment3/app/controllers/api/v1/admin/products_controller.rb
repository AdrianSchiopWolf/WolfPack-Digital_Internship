# frozen_string_literal: true

module Api
  module V1
    module Admin
      class ProductsController < Api::V1::Admin::BaseController
        # include Api::V1::Admin::ProductsControllerDoc

        def create
          product = Product.new(product_params)
          if product.save
            render json: Alba.serialize(product, with: ProductSerializer), status: :created
          else
            render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy
          product = Product.find(params[:id])
          if product.destroy
            render json: { message: 'Product deleted successfully' }, status: :no_content
          else
            render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def product_params
          params.permit(:name, :price, :category, :photo)
        end
      end
    end
  end
end
