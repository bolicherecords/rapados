class Fetchers::FetchSalesService < BaseService
  def self.execute(params = {})
    #Filter vars
    query = params[:query]
    status = params[:status]
    cash_flow = params[:cash_flow]

    #Filters
    sales = status ? Sale.where(status: status) : Sale.where(:status.ne => Sale::STATUS_CANCELLED)
    sales = sales.where(cash_flow: cash_flow) if cash_flow.present?
    sales = sales.full_text_search(query) if (query.present? && query != " ")

    #Order
    sales = sales.order(created_at: :desc)
  end

  def self.decorated(params = {})
    sales = self.execute(params)
    sales = SaleDecorator.decorate_collection(sales)
  end
end
