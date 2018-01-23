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
  has_many :dispatches
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

  def total_sales(store)
    total_sales = sales.where(store: store, status: Sale::STATUS_FINISHED).map(&:total).sum
    total_sales.present? ? total_sales : 0
  end

  def total_contributions(store)
    total_contributions = contributions.where(store: store).map(&:price).sum
    total_contributions.present? ? total_contributions : 0
  end

  def total_expenses(store)
    total_expenses = expenses.where(store: store).map(&:price).sum
    total_expenses.present? ? total_expenses : 0
  end

  def total_origin_dispatches(store)
    total_dispatches = dispatches.where(origin: store, status: Sale::STATUS_FINISHED).map(&:total).sum
    total_dispatches.present? ? total_dispatches : 0
  end

  def total_purchases(store)
    total_purchases = purchases.where(store: store, status: Sale::STATUS_FINISHED).map(&:total).sum
    total_purchases.present? ? total_purchases : 0
  end

  def total_master(store)
    total_origin_dispatches(store) + total_expenses(store)
  end

  def total_slave(store)
    total_contributions(store) + total_expenses(store)
  end

  def saldo
    master = Store.find_by(type: Store::TYPE_MASTER)
    saldo_master = self.total_master(master)
    slave = Store.find_by(type: Store::TYPE_SLAVE)
    saldo_slave = self.total_slave(slave)
    saldo_slave - saldo_master
  end

end
