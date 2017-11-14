class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :update, :destroy]

  def index
    options = params   
    @providers = Fetchers::FetchProvidersService.decorated(options)
  end

  def desactivated
    @providers = Provider.where(status: Provider::STATUS_DESACTIVATE)
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
    redirect_to providers_url
  end

  def edit
    if params[:origin] == 'ACTIVATE'
      @provider.update(status: Provider::STATUS_ACTIVATE)
      flash[:success] = 'El proveedor ha sido activado con éxito.'
      redirect_to desactivated_providers_path
    elsif params[:origin] == 'DESACTIVATE'
      @provider.update(status: Provider::STATUS_DESACTIVATE)
      flash[:success] = 'El proveedor ha sido desactivado con éxito.'
      redirect_to providers_url
    end
  end

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

  private

  def provider_params
    params.require(:provider).permit(:name, :email, :phone, :user_id, :bank, :bank_account, :seller_name)
  end

  def set_provider
    @provider = Provider.find(params[:id])
  end
end
