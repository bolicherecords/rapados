class DispatchStockService < BaseService

	def self.execute(dispatch, current_user, type)
		dispatch.dispatch_details.each do |dispatch_detail|
			if type == Stock::ADD_STOCK
				StockControlService.execute(dispatch_detail.amount, dispatch_detail.product, dispatch.origin, current_user, Stock::REMOVE_STOCK)
				StockControlService.execute(dispatch_detail.amount, dispatch_detail.product, dispatch.destination, current_user, Stock::ADD_STOCK)
			else
				StockControlService.execute(dispatch_detail.amount, dispatch_detail.product, dispatch.destination, current_user, Stock::REMOVE_STOCK)
				StockControlService.execute(dispatch_detail.amount, dispatch_detail.product, dispatch.origin, current_user, Stock::ADD_STOCK)
			end
		end
	end

end