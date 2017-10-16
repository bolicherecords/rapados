class DispatchDetailsController < ApplicationController
  before_action :set_dispatch_detail, only: [:destroy]

  def create
    dispatch = Dispatch.find(params[:dispatch])
    if dispatch.draft?
      product = Product.where(barcode: params[:barcode]).first
      if product.present?
        DispatchDetail.create(product: product, dispatch: dispatch, amount: params[:amount])
        flash[:success] = 'Producto agregado exitosamente.'
      else
        flash[:danger] = 'Código de barra no registrado'
      end
    else
      flash[:danger] = "Imposible agregar producto. Compra #{DispatchDecorator.decorate(dispatch).status_name}."
    end
    redirect_to :back
  end

  def destroy
    @dispatch = @dispatch_detail.dispatch
    @dispatch_detail.destroy ? flash[:success] = 'El producto fue quitado con éxito.' : flash[:danger] = 'No se pudo quitar el producto.'
    redirect_to @dispatch
  end

  private

  def dispatch_params
    params.require(:dispatch_details).permit(:barcode, :dispatch, :amount)
  end

  def set_dispatch_detail
    @dispatch_detail = DispatchDetail.find(params[:id])
  end
end
