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
    redirect_to @client, notice: 'Client was successfully created.'
  end

  def edit; end

  def update
    @client.update(client_params)
    redirect_to @client, notice: 'Client was successfully updated.'
  end

  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  private

  def client_params
    params.require(:client).permit(:name, :phone, :email)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
