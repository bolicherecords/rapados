class CashFlowsController < ApplicationController
  before_action :set_cash_flow, only: [:show, :edit, :update, :destroy]

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

    @dispatches = Fetchers::FetchDispatchesService.decorated(options)

    @cash_flow = CashFlowDecorator.decorate(@cash_flow)
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
    @cash_flow = params[:cash_flow].present? ? CashFlow.find(params[:cash_flow]) : CashFlow.current_cash_flow
    @stores = Store.actives
  end

  private

  def cash_flow_params
    params.require(:cash_flow).permit(:start_at, :end_at)
  end

  def set_cash_flow
    @cash_flow = CashFlow.find(params[:id])
  end
end
