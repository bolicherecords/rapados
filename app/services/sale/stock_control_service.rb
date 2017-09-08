class StockControlService < BaseService

  def self.execute(sale, type)  
 		sale.update(status: 4)
  end

end