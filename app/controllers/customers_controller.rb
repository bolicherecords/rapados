class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.where(status: Customer::STATUS_ACTIVATE)
  end

  def desactivated
    @customers = Customer.where(status: Customer::STATUS_DESACTIVATE)
  end

  def show; end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.user = current_user
    @customer.save
    flash[:success] = 'El cliente ha sido creado con éxito.'
    redirect_to customers_url
  end

  def edit
    if params[:origin] == 'ACTIVATE'
      @customer.update(status: Customer::STATUS_ACTIVATE)
      flash[:success] = 'El cliente ha sido activado con éxito.'
      redirect_to desactivated_customers_path
    elsif params[:origin] == 'DESACTIVATE'
      @customer.update(status: Customer::STATUS_DESACTIVATE)
      flash[:success] = 'El cliente ha sido desactivado con éxito.'
      redirect_to customers_url
    end
  end

  def update
    @customer.update(customer_params)
    flash[:success] = 'El cliente ha sido actualizado con éxito.'
    redirect_to customers_url
  end

  def destroy
    @customer.destroy
    flash[:success] = 'El cliente ha sido eliminado con éxito.'
    redirect_to customers_url
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :phone, :email)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
