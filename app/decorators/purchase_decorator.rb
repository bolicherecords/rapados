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

  def document_number_expiration
    self.document_number_expiration_at.strftime("%d/%m/%Y") if self.document_number_expiration_at.present?

  end
end
