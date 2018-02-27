class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  include ApplicationHelper

  def index
    options = params
    @products = Fetchers::FetchProductsService.decorated(options)
  end

  def desactivated
    @products = Product.where(status: Product::STATUS_DESACTIVATE)
  end

  def show
    @stocks = @product.get_stocks
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    @product.save
    flash[:success] = 'El producto ha sido creado con éxito.'
    redirect_to products_url
  end

  def edit
    if params[:origin] == 'ACTIVATE'
      @product.update(status: Product::STATUS_ACTIVATE)
      flash[:success] = 'El producto ha sido activado con éxito.'
      redirect_to desactivated_products_path
    elsif params[:origin] == 'DESACTIVATE'
      @product.update(status: Product::STATUS_DESACTIVATE)
      flash[:success] = 'El producto ha sido desactivado con éxito.'
      redirect_to products_url
    end
  end

  def update
    @product.update(product_params)
    flash[:success] = 'El producto ha sido actualizado con éxito.'
    redirect_to products_url
  end

  def destroy
    @product.stocks.destroy_all
    @product.destroy
    flash[:success] = 'El producto ha sido creado con éxito.'
    redirect_to products_url
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :unit, :purchase_price, :sale_price, :extra)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
