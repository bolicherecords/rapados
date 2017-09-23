class SaleStockService < BaseService

	def self.execute(sale, current_user, type)
		sale.sale_details.each do |sale_detail|
			if type == Stock::REMOVE_STOCK
				StockControlService.execute(sale_detail.amount, sale_detail.product, sale.store, current_user, '-')
			else
				StockControlService.execute(sale_detail.amount, sale_detail.product, sale.store, current_user, '+')
			end
		end
	end

end