class DispatchesController < ApplicationController

  before_action :set_dispatch, only: [:show, :edit, :update, :destroy]

  def index
    options = params
    @dispatches = Fetchers::FetchDispatchesService.decorated(options)
  end

  def cancelled
    options = params
    @dispatches = Fetchers::FetchDispatchesService.decorated(options)
  end

  def new
    @dispatch = Dispatch.new
  end

  def create
    @dispatch = Dispatch.create(dispatch_params)
    @dispatch.update(user: current_user)
    flash[:success] = 'El despacho ha sido creado con éxito.'
    redirect_to @dispatch
  end

  def show
    @dispatch = DispatchDecorator.decorate(@dispatch)
    @products = Product.where(status: Product::STATUS_ACTIVATE)
  end

  def edit
    case params[:origin]
    when "FINISHED"
      @dispatch.finish(current_user) ? flash[:success] = 'El despacho ha sido finalizado con éxito.' : flash[:danger] = "Imposible finalizar el despacho. Despacho #{DispatchDecorator.decorate(@dispatch).status_name}."
      redirect_to @dispatch
    when "CANCELLED"
      @dispatch.cancel(current_user) ? flash[:success] = 'El despacho ha sido anulado con éxito.' : flash[:danger] = "Imposible anular el despacho. Despacho #{DispatchDecorator.decorate(@dispatch).status_name}."
      redirect_to @dispatch
    end
  end

  def update
    @dispatch.update(dispatch_params)
    redirect_to @dispatch, notice: 'El despacho ha sido actualizado con éxito.'
  end

  def destroy
    @dispatch.destroy
    redirect_to dispatches_url, notice: 'El despacho ha sido eliminado con éxito.'
  end

  private
    def dispatch_params
      params.require(:dispatch).permit(:origin_id, :destination_id)
    end

    def set_dispatch
      @dispatch = Dispatch.find(params[:id])
    end


end
