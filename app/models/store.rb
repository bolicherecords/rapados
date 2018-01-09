class Store

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
	has_many   :purchase_details
  has_many   :sales
  has_many   :stocks
  belongs_to :user
  has_many :origins, class_name: "Dispatch", inverse_of: :origin
  has_many :destinations, class_name: "Dispatch", inverse_of: :destination
  has_many :users

  STATUS_DESACTIVATE = 0
  STATUS_ACTIVATE    = 1

  # == Atributos
  field :name,        type: String, default: ''
  field :city,        type: String, default: ''
  field :region,      type: String, default: ''
  field :country,     type: String, default: ''
  field :phone,       type: String, default: ''
  field :address,     type: String, default: ''
  field :timezone,    type: Integer, default: -3
  field :status,      type: Integer, default: STATUS_ACTIVATE

  # == Validaciones
  validates_presence_of :name, message: 'Debes ingresar un nombre.'

  # == Scopes
  scope :actives, -> { where(status: STATUS_ACTIVATE).order('name ASC') }
  scope :origin, ->(store) { where(id: store.id).order('name ASC') }
  scope :chupalo, ->(store) { where(status: STATUS_ACTIVATE, :id.ne => store.id).order('name ASC') }

  # == Métodos
  def get_stocks
    stocks.distinct(:product).map{|p| Stock.current_stock(p, self)}
  end

end
