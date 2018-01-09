class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  def index
    options = params
    @purchases = Fetchers::FetchPurchasesService.decorated(options)
  end

  def cancelled
    options = params
    @purchases = Fetchers::FetchPurchasesService.decorated(options)
  end

  def show
    @purchase = PurchaseDecorator.decorate(@purchase)
    @products = Product.where(status: Product::STATUS_ACTIVATE)
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.create(purchase_params)
    @purchase.update(user: current_user)
    flash[:success] = 'Compra creada exitosamente.'
    redirect_to @purchase
  end

  def edit
    case params[:origin]
    when "FINISHED"
      @purchase.finish(current_user) ? flash[:success] = 'Compra finalizada exitosamente.' : flash[:danger] = "Imposible finalizar compra. Compra #{PurchaseDecorator.decorate(@purchase).status_name}."
      redirect_to @purchase
    when "CANCELLED"
      @purchase.cancel(current_user) ? flash[:success] = 'Compra anulada exitosamente.' : flash[:danger] = "Imposible anular compra. Compra #{PurchaseDecorator.decorate(@purchase).status_name}."
      redirect_to @purchase
    end
  end

  def update
    @purchase.update(purchase_params)
    redirect_to @purchase, notice: 'Compra exitosamente editada.'
  end

  def destroy
    PurchaseStockService.execute(@purchase, current_user, Stock::REMOVE_STOCK) if @purchase.status == Purchase::STATUS_FINISHED
    @purchase.destroy
    redirect_to purchases_url, notice: 'Compra exitosamente borrada.'
  end

  private

  def purchase_params
    params.require(:purchase).permit(:name, :phone, :email, :provider_id, :store_id, :document_number, :document_number_expiration_at)
  end

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end
end
