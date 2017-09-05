class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  def index
    @stores = Store.where(status: Store::STATUS_ACTIVATE)
  end

  def desactivated
    @stores = Store.where(status: Store::STATUS_DESACTIVATE)
  end

  def show; end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    @store.user = current_user
    @store.save
    flash[:success] = 'El local ha sido creado con éxito.'
    redirect_to stores_url
  end

  def edit
    if params[:origin] == 'ACTIVATE'
      @store.update(status: Store::STATUS_ACTIVATE)
      flash[:success] = 'El local ha sido activado con éxito.'
      redirect_to desactivated_stores_path
    elsif params[:origin] == 'DESACTIVATE'
      @store.update(status: Store::STATUS_DESACTIVATE)
      flash[:success] = 'El local ha sido desactivado con éxito.'
      redirect_to stores_url
    end
  end

  def update
    @store.update(store_params)
    flash[:success] = 'El local ha sido actualizado con éxito.'
    redirect_to stores_url
  end

  def destroy
    @store.destroy
    flash[:success] = 'El local ha sido eliminado con éxito.'
    redirect_to stores_url
  end

  private

  def store_params
    params.require(:store).permit(:name, :city, :country, :phone, :address, :timezone)
  end

  def set_store
    @store = Store.find(params[:id])
  end
end
