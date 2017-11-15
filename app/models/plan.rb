class Plan

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  # include GlobalID::Identification

  # == Asociaciones
  has_many :products
  belongs_to :user

  STATUS_DESACTIVATE = 0
  STATUS_ACTIVATE    = 1

  # == Atributos
  field :name,        type: String, default: ''
  field :price,       type: Integer, default: 0
  field :status,      type: Integer, default: STATUS_ACTIVATE
  
  # == Validaciones
  validates_presence_of :name, message: 'Debes ingresar un nombre.'

  # == Buscador
  search_in :name

  # == Scopes
  scope :actives, -> { where(status: STATUS_ACTIVATE).order('name ASC') }

  # == Métodos
  def prev
    Plan.where(:name.lt => name).order(name: :desc).first
  end

  def next
    Plan.where(:name.gt => name).order(name: :asc).first
  end

end
