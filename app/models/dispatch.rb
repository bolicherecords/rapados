class Dispatch

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  # include GlobalID::Identification

  # == Asociaciones
  belongs_to  :user
  belongs_to  :origin, class_name: "Store", inverse_of: :origins
  belongs_to  :destination, class_name: "Store", inverse_of: :destinations
  belongs_to  :cash_flow_origin, class_name: "CashFlow", inverse_of: :dispatch_origins, optional: true
  belongs_to  :cash_flow_destination, class_name: "CashFlow", inverse_of: :dispatch_destinations, optional: true
  has_many    :dispatch_details

  # == Constantes
  STATUS_DRAFT      = 1
  STATUS_FINISHED   = 2
  STATUS_CANCELLED  = 3

  # == Atributos
  field :total,       type: Integer, default: 0
  field :status,      type: Integer, default: STATUS_DRAFT
  field :finish_at,   type: DateTime
  field :cancel_at,   type: DateTime

  after_create :set_cash_flow

  # == Validaciones

  # == Buscador
  search_in :status, :origin =>[:name], :destination =>[:name], :origin =>[:email]

  # == Métodos
  def draft?
    status == STATUS_DRAFT
  end

  def finish(current_user)
    if self.status == STATUS_DRAFT
      self.status = STATUS_FINISHED
      self.finish_at = Time.now
      self.save
      DispatchStockService.execute(self, current_user, Stock::ADD_STOCK)
    end
  end

  def cancel(current_user)
    if status < STATUS_CANCELLED
      DispatchStockService.execute(self, current_user, Stock::REMOVE_STOCK) if self.status == STATUS_FINISHED
      self.status = STATUS_CANCELLED
      self.cancel_at = Time.now
      self.save
    end
  end

  def total
    dispatch_details.map(&:total).sum
  end

  def set_cash_flow
    cash_flow_origin = CashFlow.current_cash_flow(origin)
    update(cash_flow_origin: cash_flow_origin)
    cash_flow_destination = CashFlow.current_cash_flow(destination)
    update(cash_flow_destination: cash_flow_destination)
  end

end
