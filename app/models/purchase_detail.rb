class PurchaseDetail

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to :purchase, optional: true
  belongs_to :product

  # == Atributos
  field :amount, type: Float, default: 0
  field :total, type: Integer, default: 0

  # == Validaciones

  # == Métodos

  def purchase_price
    total / amount
  end

  def tax
    total * 0.19
  end

  def extra
    total * product.get_extra
  end

  def total_with_tax
    total + tax + extra
  end

end
