class Dispatch
	
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to  :user
  belongs_to  :origin, class_name: "Store", inverse_of: :origins
  belongs_to  :destination, class_name: "Store", inverse_of: :destinations
  has_many    :dispatch_details

  # == Atributos

  # == Validaciones

  # == Métodos

end