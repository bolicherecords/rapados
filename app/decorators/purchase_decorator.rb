class PurchaseDecorator < Draper::Decorator
	delegate_all

	def status_name
    case source.status
    when Purchase::STATUS_DRAFT
      "Nueva"
    when Purchase::STATUS_FINISHED
      "Finalizada"
    when Purchase::STATUS_CANCELLED
      "Anulada"
    end
	end
end
