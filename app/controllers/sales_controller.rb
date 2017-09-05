class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def index
    @sales = SaleDecorator.decorate_collection(Sale.all)
  end

  def show
    @sale = SaleDecorator.decorate(@sale)
  end

  def new
    @sale = Sale.new
  end

  def create
    sale = Sale.create(client_id: sale_params[:client_id], user: current_user, store: current_user.store)
    flash[:success] = 'Venta creada exitosamente.'
    redirect_to sale
  end

  def edit
    case params[:origin]
    when "FINISHED"
      @sale.finish_sale ? flash[:success] = 'Venta finalizada exitosamente.' : flash[:danger] = "Imposible finalizar venta. Venta #{SaleDecorator.decorate(@sale).status_name}."
      redirect_to @sale
    when "CANCELLED"
      @sale.cancel_sale ? flash[:success] = 'Venta anulada exitosamente.' : flash[:danger] = "Imposible anular venta. Venta #{SaleDecorator.decorate(@sale).status_name}."
      redirect_to @sale      
    end
  end

  def update
    @sale.update(sale_params)
    flash[:success] = 'Venta actualizada exitosamente.'
    redirect_to @sale
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
