class DispatchDetailsController < ApplicationController
  before_action :set_dispatch_detail, only: [:edit, :update, :destroy]

  def create
    dispatch = Dispatch.find(params[:dispatch])
    if params[:barcode].present? && params[:amount].present?
      if dispatch.draft?
        product = Product.where(barcode: params[:barcode]).first
        if product.present?
          stock = Stock.current_stock(product, dispatch.origin)
          if stock.present? && stock.amount >= params[:amount].to_f
            DispatchDetail.create(product: product, dispatch: dispatch, amount: params[:amount], total: (product.sale_price + product.sale_price*product.get_extra) * params[:amount].to_f)
            flash[:success] = 'Producto agregado exitosamente.'
          else
            flash[:danger] = "No hay sufiente stock, actualmente hay: #{stock.present? ? stock.amount : 0}"
          end
        else
          flash[:danger] = 'Código de barra no registrado'
        end
      else
        flash[:danger] = "Imposible agregar producto. Compra #{DispatchDecorator.decorate(dispatch).status_name}."
      end
    else
      flash[:danger] = 'Debes ingresar cantidad y código de barra'
    end
    redirect_to :back
  end

  def destroy
    @dispatch = @dispatch_detail.dispatch
    @dispatch_detail.destroy ? flash[:success] = 'El producto fue quitado con éxito.' : flash[:danger] = 'No se pudo quitar el producto.'
    redirect_to @dispatch
  end

  def edit
  end

  def update
    @dispatch_detail.update(dispatch_detail_params)
    redirect_to @dispatch_detail.dispatch, notice: 'Detalle de despacho exitosamente editado.'
  end

  private

  def dispatch_params
    params.require(:dispatch_details).permit(:barcode, :dispatch, :amount)
  end

  def dispatch_detail_params
    params.require(:dispatch_detail).permit(:amount, :total)
  end

  def set_dispatch_detail
    @dispatch_detail = DispatchDetail.find(params[:id])
  end
end
