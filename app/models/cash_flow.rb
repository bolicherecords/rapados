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
  belongs_to :user

  has_many :sales
  has_many :purchases
  has_many :dispatchs
  has_many :expenses
  has_many :contributions

  # == Atributos
  field :start_at,     type: DateTime
  field :end_at,       type: DateTime
  field :status,       type: Integer, default: STATUS_ACTIVE
  field :order_number, type: Integer, default: 0

  # before_create :set_order_number

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
      CashFlow.create(user: user, start_at: Time.now, order_number: order_number + 1 )
    end
  end

  def self.current_cash_flow
    CashFlow.where(status: STATUS_ACTIVE).first
  end

  def total_purchase
    self.purchases.map{|p| p.total}.sum
  end

  def total_entry
    sales.map(&:total).sum + dispatch_origins.map(&:total).sum
  end

  def total_egress
    purchases.map(&:total).sum + expenses.map(&:price).sum + contributions.map(&:price).sum + dispatch_destinations.map(&:total).sum
  end

end
