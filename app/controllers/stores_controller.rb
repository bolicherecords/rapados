class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  def index
    @stores = Store.all
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
    redirect_to @store
  end

  def edit; end

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
