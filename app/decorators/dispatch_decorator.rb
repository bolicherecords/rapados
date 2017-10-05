class DispatchDecorator < Draper::Decorator
	delegate_all

	def status_name
    case self.status
    when Dispatch::STATUS_DRAFT
      "Nueva"
    when Dispatch::STATUS_FINISHED
      "Finalizada"
    when Dispatch::STATUS_CANCELLED
      "Anulada"
    end
	end
end
