class Sale

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Constantes
  STATUS_DRAFT            = 1
  STATUS_FINISHED         = 2
  STATUS_CANCELLED        = 3
  

  # == Asociaciones
  has_many   :sale_details
  belongs_to :store
  belongs_to :client
  belongs_to :user

  # == Atributos
  field :total, type: Integer, default: 0
  field :status, type: Integer, default: STATUS_DRAFT


  # == Validaciones
  validates_presence_of :total, message: "Debes ingresar un total."

  # == Métodos

end