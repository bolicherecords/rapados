class DispatchDetail
	
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to :dispatch
  belongs_to :product

  # == Atributos
  field :amount,        type: Integer, default: 0

  # == Validaciones
  

  # == Métodos

end