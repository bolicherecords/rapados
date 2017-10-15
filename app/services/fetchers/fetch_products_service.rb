class Fetchers::FetchProductsService < BaseService
  def self.execute(params = {})
    query = params[:query]
    products = Product.where(status: Product::STATUS_ACTIVATE)
    products = products.full_text_search(query) if (query.present? && query != " ")
    products = products.order(name: :asc)
  end

  def self.decorated(params = {})
    products = self.execute(params)
    products = ProductDecorator.decorate_collection(products)
  end
end