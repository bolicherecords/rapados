class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:edit, :update, :destroy]

  def index
    options = params
    @contributions = Fetchers::FetchContributionsService.decorated(options)
  end

  def cancelled
    options = params
    @contributions = Fetchers::FetchContributionsService.decorated(options)
  end

  def new
    @contribution = Contribution.new
  end

  def create
    store_id = contribution_params[:store_id].present? ? contribution_params[:store_id] : current_user.store_id
    contribution = Contribution.create(user: current_user, store_id: store_id, name: contribution_params[:name], price: contribution_params[:price])
    flash[:success] = 'Egreso creado exitosamente.'
    redirect_to contributions_url
  end

  def edit
    case params[:origin]
    when "CANCELLED"
      @contribution.cancel ? flash[:success] = 'Egreso anulado exitosamente.' : flash[:danger] = "Imposible anular egreso. Egreso #{ContributionDecorator.decorate(@contribution).status_name}."
      redirect_to contributions_url
    end
  end

  def update
    @contribution.update(contribution_params)
    flash[:success] = 'Egreso actualizado exitosamente.'
    redirect_to contributions_url
  end

  def destroy
    @contribution.destroy
    redirect_to contributions_url, notice: 'Egreso eliminado exitosamente.'
  end

  private

  def contribution_params
    params.require(:contribution).permit(:name, :price, :store_id)
  end

  def set_contribution
    @contribution = Contribution.find(params[:id])
  end
end
