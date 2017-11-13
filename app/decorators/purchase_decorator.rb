class PurchaseDecorator < Draper::Decorator
	delegate_all

	def status_name
    case status
    when Purchase::STATUS_DRAFT
      'Nueva'
    when Purchase::STATUS_FINISHED
      'Finalizada'
    when Purchase::STATUS_CANCELLED
      'Anulada'
    end
	end

	def document_number_expiration
		document_number_expiration_at.strftime('%d/%m/%Y') if document_number_expiration_at.present?
	end

	def created_at_datetime
		format_date(created_at)
	end

	def format_date_time(date)
		date.in_time_zone.strftime("%d/%m/%Y %H:%M") if date
	end

	def format_date(date)
		date.strftime("%d/%m/%Y") if date
	end
end
