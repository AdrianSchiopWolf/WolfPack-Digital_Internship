module Admin
  class ProductsController < Admin::BaseController
    def new
      @product = Product.new
      @products = Product.all
      render 'products/new'
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to new_admin_product_path, notice: 'Product was successfully created.'
      else
        @products = Product.all
        render :new
      end
    end

    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to new_admin_product_path, notice: 'Product was successfully destroyed.'
    end

    private

    def product_params
      params.require(:product).permit(:name, :price, :category, :photo)
    end
  end
end
  