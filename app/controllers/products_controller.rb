class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    @product.save
    redirect_to @product, notice: 'Product was successfully created.'
  end

  def edit; end

  def update
    @product.update(product_params)
    redirect_to @product, notice: 'Product was successfully updated.'
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :unit)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
