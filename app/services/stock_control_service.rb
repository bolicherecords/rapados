class StockControlService < BaseService

  def self.execute(sale, type)
 		puts "PASE POR ACA PADRE 111"
 		sale.update(status: 1)
  end

end