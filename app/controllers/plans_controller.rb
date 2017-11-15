class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def index
    options = params   
    @plans = Fetchers::FetchPlansService.decorated(options)
  end

  def desactivated
    @plans = Plan.where(status: Plan::STATUS_DESACTIVATE)
  end

  def show; end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user = current_user
    @plan.save
    flash[:success] = 'El plan ha sido creado con éxito.'
    redirect_to plans_url
  end

  def edit
    if params[:origin] == 'ACTIVATE'
      @plan.update(status: Plan::STATUS_ACTIVATE)
      flash[:success] = 'El plan ha sido activado con éxito.'
      redirect_to desactivated_plans_path
    elsif params[:origin] == 'DESACTIVATE'
      @plan.update(status: Plan::STATUS_DESACTIVATE)
      flash[:success] = 'El plan ha sido desactivado con éxito.'
      redirect_to plans_url
    end
  end

  def update
    @plan.update(plan_params)
    flash[:success] = 'El plan ha sido actualizado con éxito.'
    redirect_to plans_url
  end

  def destroy
    @plan.destroy
    flash[:success] = 'El plan ha sido eliminado con éxito.'
    redirect_to plans_url
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :price)
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end
end
