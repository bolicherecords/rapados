class Sale

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  # include GlobalID::Identification

  # == Constantes
  STATUS_DRAFT            = 1
  STATUS_FINISHED         = 2
  STATUS_CANCELLED        = 3

  # == Asociaciones
  has_many   :sale_details
  belongs_to :store
  belongs_to :user
  belongs_to :customer

  # == Atributos
  field :total,       type: Integer, default: 0
  field :status,      type: Integer, default: STATUS_DRAFT
  field :finish_at,   type: DateTime
  field :cancel_at,   type: DateTime
  field :number,      type: Integer


  # == Validaciones
  validates_presence_of :total, message: "Debes ingresar un total."

  # == Buscador
  search_in :status, :number, :store => [:name], :customer => [:name, :document_id], :user =>[:email]

  # == Métodos
  def finish(current_user)
    if self.status == STATUS_DRAFT
      self.status = STATUS_FINISHED
      self.finish_at = Time.now
      SaleStockService.execute(self, current_user, Stock::REMOVE_STOCK)
      self.save
    end
  end

  def cancel(current_user)
    if self.status < STATUS_CANCELLED
      SaleStockService.execute(self, current_user, Stock::ADD_STOCK) if self.status == STATUS_FINISHED
      self.status = STATUS_CANCELLED
      self.cancel_at = Time.now
      self.save
    end
  end

  def draft?
    status == STATUS_DRAFT
  end

  def total
    sale_details.map(&:total).sum
  end

end
