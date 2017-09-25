class SaleDetailsController < ApplicationController
  before_action :set_sale_detail, only: [:destroy]

  def create
    sale = Sale.find(params[:sale])
    if sale.is_draft?
      product = Product.where(barcode: params[:barcode]).first
      if product.present?
        SaleDetail.create(product: product, sale: sale, amount: params[:amount])
        flash[:success] = 'Producto agregado exitosamente.'
      else
        flash[:danger] = 'Código de barra no registrado'
      end
    else
      flash[:danger] = "Imposible agregar producto. Venta #{SaleDecorator.decorate(sale).status_name}."
    end
    redirect_to :back
  end

  def destroy
    @sale = @sale_detail.sale
    @sale_detail.destroy ? flash[:success] = 'El producto fue quitado con éxito.' : flash[:danger] = 'No se pudo quitar el producto.'
    redirect_to @sale
  end

  private

  def sale_params
    params.require(:sale_details).permit(:barcode, :sale, :amount)
  end

  def set_sale_detail
    @sale_detail = SaleDetail.find(params[:id])
  end
end
