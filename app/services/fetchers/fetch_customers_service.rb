class Fetchers::FetchCustomersService < BaseService
  def self.execute(params = {})
    query = params[:query]
    customers = Customer.where(status: Customer::STATUS_ACTIVATE)
    customers = customers.full_text_search(query) if (query.present? && query != " ")
    customers = customers.order(name: :asc)
  end

  def self.decorated(params = {})
    customers = self.execute(params)
    customers = CustomerDecorator.decorate_collection(customers)
  end
end