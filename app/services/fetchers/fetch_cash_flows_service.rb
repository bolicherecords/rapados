class Fetchers::FetchCashFlowsService < BaseService
  def self.execute(params = {})
    query = params[:query]
    status = params[:status]
    cash_flows = status ? CashFlow.where(status: status) : CashFlow.where(:status.ne => CashFlow::STATUS_FINISHED)
    cash_flows = CashFlow.all
    cash_flows = cash_flows.full_text_search(query) if (query.present? && query != " ")
    cash_flows = cash_flows.order(created_at: :desc)
  end

  def self.decorated(params = {})
    cash_flows = self.execute(params)
    cash_flows = CashFlowDecorator.decorate_collection(cash_flows)
  end
end