class Stock
	
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to  :product
  belongs_to  :store
  belongs_to  :user
  #TODO: Investigar relación doble DISPATCH

  # == Atributos
  field :amount,    type: Integer, default: 0


  # == Validaciones
  validates_presence_of     :amount,  message: "Debes ingresar una cantidad."

  # == Métodos

end