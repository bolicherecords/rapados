class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def index
    @sales = Sale.all
  end

  def show

  end

  def new
    @sale = Sale.new
  end

  def create
    sale = Sale.create(client_id: sale_params[:client_id], user: current_user, store: current_user.store)
    redirect_to sale, notice: 'Venta creada exitosamente.'
  end

  def edit; end

  def update
    @sale.update(sale_params)
    redirect_to @sale, notice: 'Sale was successfully updated.'
  end

  def destroy
    @sale.destroy
    redirect_to sales_url, notice: 'Sale was successfully destroyed.'
  end

  private

  def sale_params
    params.require(:sale).permit(:client_id)
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end
end
