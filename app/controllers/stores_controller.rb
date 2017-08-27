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
    flash[:success] = 'La tienda ha sido creada con éxito.'
    redirect_to @store
  end

  def edit; end

  def update
    @store.update(store_params)
    flash[:success] = 'La tienda ha sido actualizada con éxito.'
    redirect_to stores_url
  end

  def destroy
    @store.destroy
    flash[:success] = 'La tienda ha sido eliminada con éxito.'
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
