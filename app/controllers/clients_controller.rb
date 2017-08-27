class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
  end

  def show; end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user = current_user
    @client.save
    flash[:success] = 'El cliente ha sido creado con éxito.'
    redirect_to @client
  end

  def edit; end

  def update
    @client.update(client_params)
    flash[:success] = 'El cliente ha sido actualizado con éxito.'
    redirect_to clients_url
  end

  def destroy
    @client.destroy
    flash[:success] = 'El cliente ha sido eliminado con éxito.'
    redirect_to clients_url
  end

  private

  def client_params
    params.require(:client).permit(:name, :phone, :email)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
