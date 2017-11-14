class SaleDecorator < Draper::Decorator
	delegate_all

	def status_name
    case self.status
    when Sale::STATUS_DRAFT
      "Nueva"
    when Sale::STATUS_FINISHED
      "Finalizada"
    when Sale::STATUS_CANCELLED
      "Anulada"
    end
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
