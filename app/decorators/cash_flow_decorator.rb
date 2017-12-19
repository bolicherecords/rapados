class CashFlowDecorator < Draper::Decorator
  decorates_finders
  delegate_all
  
	def status_name
    case self.status
    when CashFlow::STATUS_FINISHED
      "Finalizada"
    when CashFlow::STATUS_ACTIVATE
      "Activa"
    end
	end

end