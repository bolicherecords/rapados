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

  # == Atributos
  field :name,        type: String, default: ""
  field :city,        type: String, default: ""
  field :country,     type: String, default: ""
  field :phone,       type: String, default: ""
  field :address,     type: String, default: ""
  field :timezone,    type: Integer, default: -3


  # == Validaciones
  validates_presence_of     :name,  message: "Debes ingresar un nombre."

  # == Métodos
end
