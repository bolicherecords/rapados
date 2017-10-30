class DispatchesController < ApplicationController

  before_action :set_dispatch, only: [:show, :edit, :update, :destroy]

  def index
    @dispatches = DispatchDecorator.decorate_collection(Dispatch.all)
  end

  def new
    @dispatch = Dispatch.new
  end

  def create
    @dispatch = Dispatch.create(dispatch_params)
    @dispatch.update(user: current_user)
    flash[:success] = 'Despacho creado exitosamente.'
    redirect_to @dispatch
  end

  def show
    @dispatch = DispatchDecorator.decorate(@dispatch)
    @products = Product.where(status: Product::STATUS_ACTIVATE)
  end

  def edit
    case params[:origin]
    when "FINISHED"
      @dispatch.finish(current_user) ? flash[:success] = 'Despacho finalizado exitosamente.' : flash[:danger] = "Imposible finalizar el despacho. Despacho #{DispatchDecorator.decorate(@dispatch).status_name}."
      redirect_to @dispatch
    when "CANCELLED"
      @dispatch.cancel(current_user) ? flash[:success] = 'Despacho anulado exitosamente.' : flash[:danger] = "Imposible anular el despacho. Despacho #{DispatchDecorator.decorate(@dispatch).status_name}."
      redirect_to @dispatch
    end
  end

  def update
    @dispatch.update(dispatch_params)
    redirect_to @dispatch, notice: 'Despacho exitosamente editado.'
  end

  def destroy
    @dispatch.destroy
    redirect_to dispatches_url, notice: 'Despacho exitosamente borrado.'
  end

  private
    def dispatch_params
      params.require(:dispatch).permit(:origin_id, :destination_id)
    end

    def set_dispatch
      @dispatch = Dispatch.find(params[:id])
    end


end
