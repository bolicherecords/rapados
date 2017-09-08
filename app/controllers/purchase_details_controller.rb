class PurchaseDetailsController < ApplicationController

  def create
    product = Product.where(barcode: params[:barcode]).first
    if product.present?
      PurchaseDetail.create(product: product, purchase: params[:purchase])
      flash[:success] = 'Producto agregado exitosamente.'
    else
      flash[:danger] = 'Código de barra no registrado'
    end
    redirect_to :back
  end

  private

  def purchase_params
    params.require(:purchase_details).permit(:barcode, :purchase)
  end
end
