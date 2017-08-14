class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :update, :destroy]

  def index
    @providers = Provider.all
  end

  def show; end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)
    @provider.user = current_user
    @provider.save
    redirect_to @provider, notice: 'Provider was successfully created.'
  end

  def edit; end

  def update
    @provider.update(provider_params)
    redirect_to @provider, notice: 'Provider was successfully updated.'
  end

  def destroy
    @provider.destroy
    redirect_to providers_url, notice: 'Provider was successfully destroyed.'
  end

  private

  def provider_params
    params.require(:provider).permit(:name, :email, :phone, :user_id)
  end

  def set_provider
    @provider = Provider.find(params[:id])
  end
end
