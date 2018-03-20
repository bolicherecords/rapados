class PurchaseDetail

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to :purchase, optional: true
  belongs_to :product

  # == Atributos
  field :amount,  type: Float,    default: 0
  field :price,   type: Float,    default: 0
  field :tax,     type: Float,    default: 0
  field :total,   type: Integer,  default: 0

  # == Validaciones

  # == Métodos

  def set_values
    if total.present? && price.blank? && tax.blank?
      price = total / 1.19
      tax = price * 0.19
      self.update(price: price, tax: tax)
    elsif total.blank? && self.price.present? && tax.blank?
      tax = self.price * 0.19
      total = self.price + tax
      self.update(total: total, tax: tax)
    end
  end

end
