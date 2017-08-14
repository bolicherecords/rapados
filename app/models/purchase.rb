class Purchase

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  has_many   :puchase_details
  belongs_to :store
  belongs_to :provider
  belongs_to :user

  # == Atributos
  field :total, type: Integer, default: 0

  # == Validaciones
  validates_presence_of :total, message: 'Debes ingresar un total.'

  # == Métodos
  def products
    Product.in(id: purchase_details.pluck(:product_id))
  end
end
