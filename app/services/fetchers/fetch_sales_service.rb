class Fetchers::FetchSalesService < BaseService
  def self.execute(params = {})
    query = params[:query]
    status = params[:status]
    sales = status ? Sale.where(status: status) : Sale.where(:status.ne => Sale::STATUS_CANCELLED)
    sales = sales.full_text_search(query) if (query.present? && query != " ")
    sales = sales.order(created_at: :desc)
  end

  def self.decorated(params = {})
    sales = self.execute(params)
    sales = SaleDecorator.decorate_collection(sales)
  end
end
