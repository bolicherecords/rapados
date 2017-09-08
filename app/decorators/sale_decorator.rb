class SaleDecorator < Draper::Decorator
	delegate_all

	def status_name
    case source.status
    when Sale::STATUS_DRAFT
      "Nueva"
    when Sale::STATUS_FINISHED
      "Finalizada"
    when Sale::STATUS_CANCELLED
      "Anulada"
    end
	end
  
end
