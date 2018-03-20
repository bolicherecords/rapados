class SaleDetailsController < ApplicationController
  before_action :set_sale_detail, only: [:edit, :update, :destroy]

  def create
    sale = Sale.find(params[:sale])
    if params[:barcode].present? && params[:amount].present?
      if sale.draft?
        product = Product.where(barcode: params[:barcode]).first
        if product.present?
          stock = Stock.current_stock(product, sale.store)
          if stock.present? && stock.amount >= params[:amount].to_f
            SaleDetail.create(product: product, sale: sale, amount: params[:amount], total: product.sale_price * params[:amount].to_f)
            flash[:success] = 'Producto agregado exitosamente.'
          else
            flash[:danger] = "No hay sufiente stock, actualmente hay: #{stock.present? ? stock.amount : 0}"
          end

        else
          flash[:danger] = 'Código de barra no registrado'
        end
      else
        flash[:danger] = "Imposible agregar producto. Venta #{SaleDecorator.decorate(sale).status_name}."
      end
    else
      flash[:danger] = 'Debes ingresar cantidad y código de barra'
    end
    redirect_to :back
  end

  def destroy
    @sale = @sale_detail.sale
    @sale_detail.destroy ? flash[:success] = 'El producto fue quitado con éxito.' : flash[:danger] = 'No se pudo quitar el producto.'
    redirect_to @sale
  end

  def edit
  end

  def update
    @sale_detail.update(sale_detail_params)
    redirect_to @sale_detail.sale, notice: 'Detalle de venta exitosamente editado.'
  end

  private

  def sale_params
    params.require(:sale_details).permit(:barcode, :sale, :amount)
  end

  def sale_detail_params
    params.require(:sale_detail).permit(:amount, :total)
  end

  def set_sale_detail
    @sale_detail = SaleDetail.find(params[:id])
  end
end
