class ProductDecorator < Draper::Decorator
  decorates_finders
  delegate_all

  def stock_amount
  	self.current_stock.amount
  end

  
end