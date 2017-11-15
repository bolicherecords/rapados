class Fetchers::FetchPlansService < BaseService
  def self.execute(params = {})
    query = params[:query]
    plans = Plan.where(status: Plan::STATUS_ACTIVATE)
    plans = plans.full_text_search(query) if (query.present? && query != " ")
    plans = plans.order(name: :asc)
  end

  def self.decorated(params = {})
    plans = self.execute(params)
    plans = PlanDecorator.decorate_collection(plans)
  end
end