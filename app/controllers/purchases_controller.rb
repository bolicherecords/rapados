class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  def index
    @purchases = Purchase.all
  end

  def show; end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.user = current_user
    @purchase.save
    redirect_to @purchase, notice: 'Purchase was successfully created.'
  end

  def edit; end

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
    params.require(:purchase).permit(:name, :phone, :email)
  end

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end
end
