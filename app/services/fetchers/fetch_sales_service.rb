class Fetchers::FetchSalesService < BaseService
  def self.execute(params = {})
    query = params[:query]
    sales = Sale.all
    sales = sales.full_text_search(query) if (query.present? && query != " ")
    sales = sales.order(created_at: :desc)
  end

  def self.decorated(params = {})
    sales = self.execute(params)
    sales = SaleDecorator.decorate_collection(sales)
  end
end