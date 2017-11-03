class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def index
    options = params   
    @sales = Fetchers::FetchSalesService.decorated(options)
  end

  def show
    @sale = SaleDecorator.decorate(@sale)
    @products = Product.where(status: Product::STATUS_ACTIVATE)
  end

  def new
    @sale = Sale.new
  end

  def create
    store_id = sale_params[:store_id].present? ? sale_params[:store_id] : current_user.store_id
    sale = Sale.create(customer_id: sale_params[:customer_id], user: current_user, store_id: store_id, number: sale_params[:number])
    flash[:success] = 'Venta creada exitosamente.'
    redirect_to sale
  end

  def edit
    case params[:origin]
    when "FINISHED"
      @sale.finish(current_user) ? flash[:success] = 'Venta finalizada exitosamente.' : flash[:danger] = "Imposible finalizar venta. Venta #{SaleDecorator.decorate(@sale).status_name}."
      redirect_to @sale
    when "CANCELLED"
      @sale.cancel(current_user) ? flash[:success] = 'Venta anulada exitosamente.' : flash[:danger] = "Imposible anular venta. Venta #{SaleDecorator.decorate(@sale).status_name}."
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
    params.require(:sale).permit(:customer_id, :number, :store_id)
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end
end
