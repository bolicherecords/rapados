class CashFlowDecorator < Draper::Decorator
  # decorates_finders
  delegate_all

	def status_name
    case self.status
    when CashFlow::STATUS_FINISHED
      "Finalizada"
    when CashFlow::STATUS_ACTIVE
      "Activa"
    end
	end

  def start_at_date
    format_date(start_at)
  end

  def end_at_date
    format_date(end_at)
  end

  def format_date_time(date)
    date.in_time_zone.strftime("%d/%m/%Y %H:%M") if date
  end

  def format_date(date)
    date.strftime("%d/%m/%Y") if date
  end

end
