class PurchaseDetailsController < ApplicationController
  before_action :set_purchase_detail, only: [:destroy]

  def create
    purchase = Purchase.find(params[:purchase])
    if params[:barcode].present? && params[:amount].present?
      if purchase.draft?
        product = Product.where(barcode: params[:barcode]).first
        if product.present?
          purchase_detail = PurchaseDetail.create(product: product, purchase: purchase, amount: params[:amount], price: params[:price], tax: params[:tax], total: params[:total])
          purchase_detail.set_values

          flash[:success] = 'Producto agregado exitosamente.'
        else
          flash[:danger] = 'Código de barra no registrado'
        end
      else
        flash[:danger] = "Imposible agregar producto. Compra #{PurchaseDecorator.decorate(purchase).status_name}."
      end
    else
      flash[:danger] = 'Debes ingresar cantidad y código de barra'
    end
    redirect_to purchase
  end

  def destroy
    @purchase = @purchase_detail.purchase
    @purchase_detail.destroy ? flash[:success] = 'El producto fue quitado con éxito.' : flash[:danger] = 'No se pudo quitar el producto.'
    redirect_to @purchase
  end

  private

  def purchase_params
    params.require(:purchase_details).permit(:barcode, :purchase, :amount, :price, :total, :tax)
  end

  def set_purchase_detail
    @purchase_detail = PurchaseDetail.find(params[:id])
  end
end
