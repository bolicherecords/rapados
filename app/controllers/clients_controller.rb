class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.where(status: Client::STATUS_ACTIVATE)
  end

  def desactivated
    @clients = Client.where(status: Client::STATUS_DESACTIVATE)
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
    redirect_to clients_url
  end

  def edit
    if params[:origin] == 'ACTIVATE'
      @client.update(status: Client::STATUS_ACTIVATE)
      flash[:success] = 'El cliente ha sido activado con éxito.'
      redirect_to desactivated_clients_path
    elsif params[:origin] == 'DESACTIVATE'
      @client.update(status: Client::STATUS_DESACTIVATE)
      flash[:success] = 'El cliente ha sido desactivado con éxito.'
      redirect_to clients_url
    end
  end

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
