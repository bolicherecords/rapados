class Contribution
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  # include GlobalID::Identification

  # == Constantes
  STATUS_DESACTIVATE = 0
  STATUS_ACTIVATE    = 1

  # == Asociaciones
  belongs_to :store
  belongs_to :user

  # == Atributos
  field :name,          type: String, default: ''
  field :price,         type: Integer, default: 0
  field :status,        type: Integer, default: STATUS_ACTIVATE

  # == Validaciones
  validates_presence_of :price, message: 'Debes ingresar un precio.'

  # == Buscador
  search_in :name, :price, :status

  # == Métodos
  def prev
    Contribution.where(:name.lt => name).order(name: :desc).first
  end

  def next
    Contribution.where(:name.gt => name).order(name: :asc).first
  end

end
