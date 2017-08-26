class SaleDetailsController < ApplicationController

  def create
    product = Product.where(barcode: params[:barcode]).first
    if product.present?
      SaleDetail.create(product: product, sale: params[:sale])
      notice = 'Producto agregado exitosamente.'
    else
      notice = 'Código de barra no registrado'
    end
    redirect_to :back, notice: notice
  end

  private

  def sale_params
    params.require(:sale_details).permit(:barcode, :sale)
  end

end
