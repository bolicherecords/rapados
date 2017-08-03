class Sale

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  has_many   :sale_details
  belongs_to :store
  belongs_to :client
  belongs_to :user

  # == Atributos
  field :total,        type: Integer, default: 0

  # == Validaciones
  validates_presence_of     :total,  message: "Debes ingresar un total."

  # == Métodos

end