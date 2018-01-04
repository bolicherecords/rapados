class Fetchers::FetchExpensesService < BaseService
  def self.execute(params = {})
    query = params[:query]
    status = params[:status]
    cash_flow = params[:cash_flow]

    expenses = status ? Expense.where(status: status) : Expense.where(:status.ne => Expense::STATUS_CANCELLED)
    expenses = expenses.where(cash_flow: cash_flow) if cash_flow.present?
    expenses = expenses.full_text_search(query) if (query.present? && query != " ")

    expenses = expenses.order(created_at: :desc)
    
  end

  def self.decorated(params = {})
    expenses = self.execute(params)
    expenses = ExpenseDecorator.decorate_collection(expenses)
  end
end
