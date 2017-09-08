class StockControlService < BaseService

  def self.execute(sale, type)
  	raise sale.inspect
 		sale.update(status: 4)
  end

end