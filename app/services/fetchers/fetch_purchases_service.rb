class Fetchers::FetchPurchasesService < BaseService
  def self.execute(params = {})
    query = params[:query]
    purchases = Purchase.all
    purchases = purchases.full_text_search(query) if (query.present? && query != " ")
    purchases = purchases.sort({document_number_expiration_at: 1})
  end

  def self.decorated(params = {})
    purchases = self.execute(params)
    purchases = PurchaseDecorator.decorate_collection(purchases)
  end
end
