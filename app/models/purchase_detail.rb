class PurchaseDetail
	
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to :purchase
  belongs_to :product

  # == Atributos
  field :amount,        type: Integer, default: 0

  # == Validaciones
  validates_presence_of     :total,  message: "Debes ingresar una cantidad."

  # == Métodos

end