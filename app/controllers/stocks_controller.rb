class StocksController < ApplicationController

	def index
		@stocks = Stock.get_stocks
	end

end