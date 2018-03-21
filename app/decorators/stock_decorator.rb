class StockDecorator < Draper::Decorator
  decorates_finders
  delegate_all

  def created_at_datetime
  	format_date(created_at)
  end

  def updated_at_datetime
  	format_date(created_at)
  end

  def format_date(date)
    date.strftime('%d/%m/%Y') if date
  end

end
