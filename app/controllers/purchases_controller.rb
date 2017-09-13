class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  def index
    @purchases = PurchaseDecorator.decorate_collection(Purchase.all)
  end

  def show
    @purchase = PurchaseDecorator.decorate(@purchase)
    @products = Product.where(status: Product::STATUS_ACTIVATE).pluck(:name, :barcode)
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.create(provider_id: params[:purchase][:provider_id],
                                user: current_user,
                                store: current_user.store)
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
    redirect_to @purchase, notice: 'Purchase was successfully updated.'
  end

  def destroy
    @purchase.destroy
    redirect_to purchases_url, notice: 'Purchase was successfully destroyed.'
  end

  private

  def purchase_params
    params.require(:purchase).permit(:name, :phone, :email, :provider_id)
  end

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end
end
