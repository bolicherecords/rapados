class ProvidersController < ApplicationController

	before_filter :set_provider, only: [:edit, :update]

  def index
  	@providers = Provider.all
  end

  def new
  	@provider = Provider.new
  end

  def create
  	@provider = Provider.new(provider_params)
  	@provider.user = current_user
  	@provider.save
  	redirect_to providers_path, notice: 'Proveedor was successfully created.'
  end

  def edit
  	
  end

  def update
  	
  end

  private
  	def set_provider
  		@provider = Provider.find(params[:id])
  	end

  	def provider_params
      params.require(:provider).permit(:name, :phone, :email)
    end

end