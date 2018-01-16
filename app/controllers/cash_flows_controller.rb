class CashFlowsController < ApplicationController
  before_action :set_cash_flow, only: [:show, :edit, :update, :destroy, :cash_flow_report]

  def index
    options = params
    @cash_flows = Fetchers::FetchCashFlowsService.decorated(options)
  end

  def show
    options = {}
    options[:cash_flow] = @cash_flow
    @sales = Fetchers::FetchSalesService.decorated(options)
    @sales = Fetchers::FetchSalesService.decorated(options)
    @purchases = Fetchers::FetchPurchasesService.decorated(options)
    @expenses = Fetchers::FetchExpensesService.decorated(options)
    @contributions = Fetchers::FetchContributionsService.decorated(options)
    options[:origin] = true
    @dispatches_origin = Fetchers::FetchDispatchesService.decorated(options)
    options[:destination] = true
    @dispatches_destination = Fetchers::FetchDispatchesService.decorated(options)
    @cash_flow = CashFlowDecorator.decorate(@cash_flow)
  end

  def new
    @cash_flow = CashFlow.new
  end

  def create
    store_id = cash_flow_params[:store_id].present? ? cash_flow_params[:store_id] : current_user.store_id
    @cash_flow = CashFlow.create(user: current_user, store_id: store_id, start_at: cash_flow_params[:start_at], end_at: cash_flow_params[:end_at])
    flash[:success] = 'Caja creada exitosamente.'
    redirect_to cash_flows_url
  end

  def edit
    case params[:origin]
    when "FINISHED"
      @cash_flow.finish ? flash[:success] = 'Caja finalizada exitosamente.' : flash[:danger] = "Imposible finalizar caja. Caja #{CashFlowDecorator.decorate(@cash_flow).status_name}."
      redirect_to cash_flows_url
    end
  end

  def update
    @cash_flow.update(cash_flow_params)
    flash[:success] = 'Caja actualizada exitosamente.'
    redirect_to cash_flows_url
  end

  def destroy
    @cash_flow.destroy
    redirect_to cash_flows_url, notice: 'Caja eliminada exitosamente.'
  end

  def cash_flow_report

  end

  private

  def cash_flow_params
    params.require(:cash_flow).permit(:start_at, :end_at, :store_id)
  end

  def set_cash_flow
    @cash_flow = CashFlow.find(params[:id])
  end
end
