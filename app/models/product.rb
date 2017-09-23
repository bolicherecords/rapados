class Product

	# == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  has_many    :sale_details
  has_many    :purchase_details
  has_many    :dispatch_details
  has_many    :stocks
  belongs_to  :user

  STATUS_DESACTIVATE = 0
  STATUS_ACTIVATE    = 1

  # == Atributos
  field :name,        type: String, default: ''
  field :description, type: String, default: ''
  field :unit,        type: String, default: ''
  field :barcode,     type: String, default: ''
  field :status,      type: Integer, default: STATUS_ACTIVATE

  # == Validaciones
  validates_presence_of :name, message: 'Debes ingresar un nombre.'

  # == Métodos

	def purchases
		Purchase.in(id: purchase_details.pluck(:pucharse_id))
	end
  
  def get_stocks
    stocks.distinct(:store).map{|s| Stock.current_stock(self, s)}
  end

end
