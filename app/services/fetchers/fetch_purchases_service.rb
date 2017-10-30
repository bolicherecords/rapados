class Fetchers::FetchPurchasesService < BaseService
  def self.execute(params = {})
    query = params[:query]
    purchases = Purchase.all
    purchases = purchases.full_text_search(query) if (query.present? && query != " ")
    purchases = purchases.order(created_at: :desc)
  end

  def self.decorated(params = {})
    purchases = self.execute(params)
    purchases = PurchaseDecorator.decorate_collection(purchases)
  end
end