class CostumersController < ApplicationController
  before_action :set_costumer, only: [:show, :edit, :update, :destroy]

  def index
    @costumers = Client.where(status: Client::STATUS_ACTIVATE)
  end

  def desactivated
    @costumers = Client.where(status: Client::STATUS_DESACTIVATE)
  end

  def show; end

  def new
    @costumer = Client.new
  end

  def create
    @costumer = Client.new(costumer_params)
    @costumer.user = current_user
    @costumer.save
    flash[:success] = 'El cliente ha sido creado con éxito.'
    redirect_to costumers_url
  end

  def edit
    if params[:origin] == 'ACTIVATE'
      @costumer.update(status: Client::STATUS_ACTIVATE)
      flash[:success] = 'El cliente ha sido activado con éxito.'
      redirect_to desactivated_costumers_path
    elsif params[:origin] == 'DESACTIVATE'
      @costumer.update(status: Client::STATUS_DESACTIVATE)
      flash[:success] = 'El cliente ha sido desactivado con éxito.'
      redirect_to costumers_url
    end
  end

  def update
    @costumer.update(costumer_params)
    flash[:success] = 'El cliente ha sido actualizado con éxito.'
    redirect_to costumers_url
  end

  def destroy
    @costumer.destroy
    flash[:success] = 'El cliente ha sido eliminado con éxito.'
    redirect_to costumers_url
  end

  private

  def costumer_params
    params.require(:costumer).permit(:name, :phone, :email)
  end

  def set_costumer
    @costumer = Costumer.find(params[:id])
  end
end
