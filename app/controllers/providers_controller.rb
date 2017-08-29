class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :update, :destroy, :toggle_activated, :toggle_desactivated]

  def index
    @providers = Provider.where(status: 1)
  end

  def show; end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)
    @provider.user = current_user
    @provider.save
    flash[:success] = 'El proveedor ha sido creado con éxito.'
    redirect_to @provider, notice: 'Provider was successfully created.'
  end

  def edit; end

  def update
    @provider.update(provider_params)
    flash[:success] = 'El proveedor ha sido actualizado con éxito.'
    redirect_to providers_url
  end

  def destroy
    @provider.destroy
    flash[:success] = 'El proveedor ha sido creado con éxito.'
    redirect_to providers_url
  end

  def desactivated
    @providers = Provider.where(status: 0)
  end

  def toggle_activated
    @provider.update!(status: 1)
    flash[:success] = 'El proveedor ha sido activado con éxito.'
    redirect_to desactivated_providers_path
  end

  def toggle_desactivated
    @provider.update!(status: 0)
    flash[:success] = 'El proveedor ha sido desactivado con éxito.'
    redirect_to providers_url
  end

  private

  def provider_params
    params.require(:provider).permit(:name, :email, :phone, :user_id)
  end

  def set_provider
    @provider = Provider.find(params[:id])
  end
end
