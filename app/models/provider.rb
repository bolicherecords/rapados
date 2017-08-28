class Provider

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  has_many  :purchases
  belongs_to :user

  # == Atributos
  field :name,        type: String, default: ""
  field :document_id, type: String, default: ""
  field :phone,       type: String, default: ""
  field :email,       type: String, default: ""
  field :status,      type: Integer, default: 1

  # == Validaciones
  validates_presence_of     :name,  message: "Debes ingresar un nombre."

  # == Métodos
  def prev
    Area.where(:name.lt => self.name).order(name: :desc).first
  end

  def next
    Area.where(:name.gt => self.name).order(name: :asc).first
  end

end
