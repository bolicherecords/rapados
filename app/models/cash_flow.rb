class CashFlow
  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  # include GlobalID::Identification

  # == Constantes
  STATUS_ACTIVE     = 1
  STATUS_FINISHED   = 0

  # == Asociaciones
  belongs_to :store
  belongs_to :user

  has_many :sales
  has_many :purchases
  has_many :dispatch_origins, class_name: "Dispatch", inverse_of: :cash_flow_origin
  has_many :dispatch_destinations, class_name: "Dispatch", inverse_of: :cash_flow_destination
  has_many :expenses
  has_many :contributions

  # == Atributos
  field :start_at,     type: DateTime
  field :end_at,       type: DateTime
  field :status,       type: Integer, default: STATUS_ACTIVE

  # == Buscador
  search_in :start_at, :end_at, :status

  # == Métodos
  def prev
    CashFlow.where(:start_at.lt => start_at).order(start_at: :desc).first
  end

  def next
    CashFlow.where(:start_at.gt => start_at).order(start_at: :asc).first
  end

  def finish
    if self.status >= STATUS_FINISHED
      self.status = STATUS_FINISHED
      self.end_at = Time.now
      self.save
      CashFlow.create(store: self.store, user: self.user, start_at: Time.now)
    end
  end

  def self.current_cash_flow(store)
    CashFlow.where(store: store, status: STATUS_ACTIVE).first
  end

  def total_purchase
    self.purchases.map{|p| p.total}.sum
  end

end
