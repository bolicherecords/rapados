class Fetchers::FetchContributionsService < BaseService
  def self.execute(params = {})
    query = params[:query]
    status = params[:status]
    cash_flow = params[:cash_flow]

    contritutions = status ? Contribution.where(status: status) : Contribution.where(:status.ne => Contribution::STATUS_CANCELLED)
    contritutions = contritutions.where(cash_flow: cash_flow) if cash_flow.present?
    contritutions = contritutions.full_text_search(query) if (query.present? && query != " ")
    contritutions = contritutions.order(created_at: :desc)
  end

  def self.decorated(params = {})
    contritutions = self.execute(params)
    contritutions = ContributionDecorator.decorate_collection(contritutions)
  end
end