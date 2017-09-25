class Purchase

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  # include GlobalID::Identification

  # == Asociaciones
  has_many   :purchase_details
  belongs_to :store
  belongs_to :provider
  belongs_to :user

  # == Constantes
  STATUS_DRAFT            = 1
  STATUS_FINISHED         = 2
  STATUS_CANCELLED        = 3

  # == Atributos
  field :total, type: Integer, default: 0
  field :status,      type: Integer, default: STATUS_DRAFT
  field :finish_at,   type: DateTime
  field :cancel_at,   type: DateTime
  

  # == Validaciones

  # == Métodos
  def products
    Product.in(id: purchase_details.pluck(:product_id))
  end

  def finish(current_user)
    if self.status == STATUS_DRAFT
      self.status = STATUS_FINISHED
      self.finish_at = Time.now
      self.save
      PurchaseStockService.execute(self, current_user, Stock::ADD_STOCK)
    end
  end

  def cancel(current_user)
    if status < STATUS_CANCELLED
      PurchaseStockService.execute(self, current_user, Stock::REMOVE_STOCK) if self.status == STATUS_FINISHED
      self.status = STATUS_CANCELLED
      self.cancel_at = Time.now
      self.save
    end
  end

  def is_draft?
    self.status == STATUS_DRAFT
  end
  
end
