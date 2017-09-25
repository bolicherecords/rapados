class SaleStockService < BaseService

	def self.execute(sale, current_user, type)
		sale.sale_details.each do |sale_detail|
			StockControlService.execute(sale_detail.amount, sale_detail.product, sale.store, current_user, type)
		end
	end

end