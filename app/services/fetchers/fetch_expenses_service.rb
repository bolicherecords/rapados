class Fetchers::FetchExpensesService < BaseService
  def self.execute(params = {})
    query = params[:query]
    status = params[:status]
    #raise params.inspect
    dispatches = status ? Expense.where(status: status) : Expense.where(:status.ne => Expense::STATUS_CANCELLED)
    dispatches = dispatches.full_text_search(query) if (query.present? && query != " ")
    dispatches = dispatches.order(created_at: :desc)
  end

  def self.decorated(params = {})
    dispatches = self.execute(params)
    dispatches = ExpenseDecorator.decorate_collection(dispatches)
  end
end
