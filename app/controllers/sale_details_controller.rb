class SaleDetailsController < ApplicationController

  def create
    sale = Sale.find(params[:sale])
    if sale.is_draft?
      product = Product.where(id: params[:barcode]).first
      if product.present?
        SaleDetail.create(product: product, sale: sale)
        flash[:success] = 'Producto agregado exitosamente.'
      else
        flash[:danger] = 'Código de barra no registrado'
      end
    else
      flash[:danger] = "Imposible agregar producto. Venta #{SaleDecorator.decorate(sale).status_name}."
    end
    redirect_to :back
  end

  private

  def sale_params
    params.require(:sale_details).permit(:barcode, :sale)
  end
end
