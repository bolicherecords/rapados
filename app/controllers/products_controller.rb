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
    flash[:success] = 'El producto ha sido creado con éxito.'
    redirect_to @product
  end

  def edit; end

  def update
    @product.update(product_params)
    flash[:success] = 'El producto ha sido actualizado con éxito.'
    redirect_to products_url
  end

  def destroy
    @product.destroy
    flash[:success] = 'El producto ha sido creado con éxito.'
    redirect_to products_url
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :unit)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
