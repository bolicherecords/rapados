class StockControlService < BaseService

  def self.execute(amount, product, store, user, type)
 		stock = Stock.current_stock(product, store)
		new_stock = Stock.new(store: store, product: product, user: user)
		if type == Stock::REMOVE_STOCK		
			new_stock.amount = stock.present? ? (stock.amount - amount) : -amount
 		else 				
			new_stock.amount = stock.present? ? (stock.amount + amount) : amount
 		end
		new_stock.save
  end

end