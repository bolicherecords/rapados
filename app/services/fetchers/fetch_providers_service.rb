class Fetchers::FetchProvidersService < BaseService
  def self.execute(params = {})
    query = params[:query]
    providers = Provider.where(status: Provider::STATUS_ACTIVATE)
    providers = providers.full_text_search(query) if (query.present? && query != " ")
    providers = providers.order(name: :asc)
  end

  def self.decorated(params = {})
    providers = self.execute(params)
    providers = ProviderDecorator.decorate_collection(providers)
  end
end