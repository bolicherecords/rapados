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

  def plan_price
    product.plan.price
  end

  def total_plan
    plan_price * amount
  end

  def total_detail
    total + total_plan
  end
  
end
