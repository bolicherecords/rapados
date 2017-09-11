class StockControlService < BaseService

  def self.execute(amount, product, store, user, type)
 		stock = Stock.where(store: store, product: product).desc(:created_at).limit(1).first
		new_stock = Stock.new(store: store, product: product, user: user)
		if type == "-"			
			new_stock.amount = stock.present? ? (stock.amount - amount) : -amount
 		else 				
			new_stock.amount = stock.present? ? (stock.amount + amount) : amount
 		end
		new_stock.save
  end

end