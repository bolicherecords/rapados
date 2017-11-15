class Provider

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  # include GlobalID::Identification

  # == Asociaciones
  has_many :purchases
  belongs_to :user

  STATUS_DESACTIVATE = 0
  STATUS_ACTIVATE    = 1

  # == Atributos
  field :name,          type: String, default: ''
  field :document_id,   type: String, default: ''
  field :phone,         type: String, default: ''
  field :email,         type: String, default: ''
  field :status,        type: Integer, default: STATUS_ACTIVATE
  field :bank,          type: String, default: ''
  field :bank_account,  type: String, default: ''
  field :seller_name,   type: String, default: ''
  
  # == Validaciones
  validates_presence_of :name, message: 'Debes ingresar un nombre.'

  # == Buscador
  search_in :name, :document_id, :phone, :email #Ej: Relations :job_titles => [:job_position_detail, :area_name, :category_name]

  # == Scopes
  scope :actives, -> { where(status: STATUS_ACTIVATE).order('name ASC') }

  # == Métodos
  def prev
    Provider.where(:name.lt => name).order(name: :desc).first
  end

  def next
    Provider.where(:name.gt => name).order(name: :asc).first
  end

end
