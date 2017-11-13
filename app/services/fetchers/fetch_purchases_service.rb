class Fetchers::FetchPurchasesService < BaseService
  def self.execute(params = {})
    # byebug
    query = params[:query]
    status = params[:status]
    purchases = status ? Purchase.where(status: status) : Purchase.all
    purchases = purchases.full_text_search(query) if (query.present? && query != " ")
    purchases = purchases.sort({document_number_expiration_at: 1})
  end

  def self.decorated(params = {})
    purchases = self.execute(params)
    purchases = PurchaseDecorator.decorate_collection(purchases)
  end
end
