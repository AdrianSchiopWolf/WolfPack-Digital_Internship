# frozen_string_literal: true

class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @products = Product.all
    filter_by_category
    filter_by_price
    sort_products

    if turbo_frame_request?
      render partial: 'list_products', locals: { products: @products, is_dash: false }
    else
      render :index
    end
  end

  private

  def filter_by_category
    @products = @products.where(category: params[:category]) if params[:category].present? && params[:category] != 'All'
  end

  def filter_by_price
    return unless params[:min_price].present? && params[:max_price].present?

    min_price = params[:min_price].to_f
    max_price = params[:max_price].to_f
    @products = @products.where(price: min_price..max_price)
  end

  def sort_products
    @products = @products.order(price: params[:sort]) if %w[asc desc].include?(params[:sort])
  end
end
