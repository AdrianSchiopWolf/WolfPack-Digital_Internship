class ProductsController < ApplicationController
  skip_before_action :require_login!, only: [:index]
  
  def index
    @products = Product.all
    filter_by_category
    filter_by_price
    sort_products
    respond_to do |format|
      format.html # index.html.erb
      format.turbo_stream { render partial: 'products/products_list', locals: { products: @products } }
    end
  end

  def new
    @product = Product.new
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to new_product_path, notice: 'Product was successfully created.'
    else
      @products = Product.all
      render :new
    end
  end

  private

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully destroyed.'
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

  def product_params
    params.require(:product).permit(:name, :price, :category, :photo)
  end
end
