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
