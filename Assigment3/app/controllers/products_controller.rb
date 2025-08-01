class ProductsController < ApplicationController
  def index
    @products = Product.all

    @products = @products.where(category: params[:category]) if params[:category].present? && params[:category] != 'All'

    if params[:sort].present?
      puts "Sorting products by price in #{params[:sort]} order"
      if params[:sort] == 'asc'
        @products = @products.order(price: :asc)
      elsif params[:sort] == 'desc'
        @products = @products.order(price: :desc)
      end
    end

    return unless params[:min_price].present? && params[:max_price].present?

    min_price = params[:min_price].to_f
    max_price = params[:max_price].to_f
    @products = @products.where(price: min_price..max_price)
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

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category, :photo)
  end
end
