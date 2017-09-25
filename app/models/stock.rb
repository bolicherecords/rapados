class Stock
	
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to  :product
  belongs_to  :store
  belongs_to  :user
  
  # == Constantes
  ADD_STOCK               = 1
  REMOVE_STOCK            = 0

  # == Atributos
  field :amount,    type: Integer, default: 0


  # == Validaciones
  validates_presence_of     :amount,  message: "Debes ingresar una cantidad."

  # == Métodos
  def self.current_stock(product, store)
    Stock.where(product:product, store: store).desc(:created_at).limit(1).first
  end

end 