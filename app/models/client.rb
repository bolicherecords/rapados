class Client
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification
  # == Asociaciones

  STATUS_DESACTIVATE = 0
  STATUS_ACTIVATE    = 1

  has_many :sales
  belongs_to :user

  # == Atributos
  field :name,        type: String, default: ''
  field :document_id, type: String, default: ''
  field :phone,       type: String, default: ''
  field :email,       type: String, default: ''
  field :status,      type: Integer, default: STATUS_ACTIVATE

  # == Validaciones
  validates_presence_of :name, message: 'Debes ingresar un nombre.'

  # == Métodos
  def prev
    Area.where(:name.lt => name).order(name: :desc).first
  end

  def next
    Area.where(:name.gt => name).order(name: :asc).first
  end

end
