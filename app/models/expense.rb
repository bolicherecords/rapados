class Expense
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  # include GlobalID::Identification

  # == Constantes
  STATUS_FINISHED   = 1
  STATUS_CANCELLED  = 2

  # == Asociaciones
  belongs_to :store
  belongs_to :user

  # == Atributos
  field :name,          type: String, default: ''
  field :price,         type: Integer, default: 0
  field :status,        type: Integer, default: STATUS_FINISHED
  field :cancel_at,     type: DateTime

  # == Validaciones
  validates_presence_of :price, message: 'Debes ingresar un precio.'

  # == Buscador
  search_in :name, :price, :status

  # == Métodos
  def prev
    Expense.where(:name.lt => name).order(name: :desc).first
  end

  def next
    Expense.where(:name.gt => name).order(name: :asc).first
  end

  def cancel
    if self.status < STATUS_CANCELLED
      self.status = STATUS_CANCELLED
      self.cancel_at = Time.now
      self.save
    end
  end

end
