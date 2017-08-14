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
    redirect_to @store, notice: 'Store was successfully created.'
  end

  def edit; end

  def update
    @store.update(store_params)
    redirect_to @store, notice: 'Store was successfully updated.'
  end

  def destroy
    @store.destroy
    redirect_to stores_url, notice: 'Store was successfully destroyed.'
  end

  private

  def store_params
    params.require(:store).permit(:name, :city, :country, :phone, :address, :timezone)
  end

  def set_store
    @store = Store.find(params[:id])
  end
end
