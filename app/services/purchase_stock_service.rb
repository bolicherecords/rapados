class PurchaseStockService < BaseService

	def self.execute(purchase, current_user, type)
		purchase.purchase_details.each do |purchase_detail|
			StockControlService.execute(purchase_detail.amount, purchase_detail.product, purchase.store, current_user, type)
		end
	end

end