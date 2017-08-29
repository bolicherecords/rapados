class BaseDecorator < Draper::Decorator
  decorates_finders
  delegate_all

  def created_at
    format_date_time(source.created_at)
  end

  def created_at_date
    format_date(source.created_at)
  end

  def updated_at
    format_date_time(source.updated_at)
  end

  def updated_at_date
    format_date(source.updated_at)
  end

  def format_date(date)
    date.strftime("%d.%m.%Y") if date
  end

  def format_date_time(date)
    #Time.zone = 'America/Santiago'
    date.in_time_zone.strftime("%d.%m.%Y - %H:%M") if date
  end

  def format_time(date)
    date.strftime("%H:%M") if date
  end

  def format_currency(number)
    h.number_to_currency(number, unit: "$ ", precision: 0, format: "%u%n")
  end
end