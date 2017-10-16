class PurchaseDetail

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to :purchase, optional: true
  belongs_to :product

  # == Atributos
  field :amount, type: Integer, default: 0
  field :total, type: Integer, default: 0

  # == Validaciones

  # == Métodos

end
