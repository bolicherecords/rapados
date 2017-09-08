class PurchaseDecorator < Draper::Decorator
	delegate_all

	def status_name
    case self.status
    when Purchase::STATUS_DRAFT
      "Nueva"
    when Purchase::STATUS_FINISHED
      "Finalizada"
    when Purchase::STATUS_CANCELLED
      "Anulada"
    end
	end
end
