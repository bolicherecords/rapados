class Dispatch
	
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to  :user
  has_many    :dispatch_details
  #TODO: Investigar relación doble STORE

  # == Atributos

  # == Validaciones

  # == Métodos

end