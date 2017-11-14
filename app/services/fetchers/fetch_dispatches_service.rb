class Fetchers::FetchDispatchesService < BaseService
  def self.execute(params = {})
    query = params[:query]
    status = params[:status]
    dispatches = status ? Dispatch.where(status: status) : Dispatch.where(:status.ne => Dispatch::STATUS_CANCELLED)
    dispatches = dispatches.full_text_search(query) if (query.present? && query != " ")
    dispatches = dispatches.order(created_at: :desc)
  end

  def self.decorated(params = {})
    dispatches = self.execute(params)
    dispatches = DispatchDecorator.decorate_collection(dispatches)
  end
end
