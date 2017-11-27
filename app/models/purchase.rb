class Purchase

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
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
  field :status,                        type: Integer, default: STATUS_DRAFT
  field :finish_at,                     type: DateTime
  field :cancel_at,                     type: DateTime
  field :document_number,               type: Integer
  field :document_number_expiration_at, type: Date, default: Date.today

  # == Validaciones

  # == Buscador
  search_in :status, :document_number, :store => [:name], :provider => [:name, :document_id], :user =>[:email]

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

  def draft?
    status == STATUS_DRAFT
  end

  def total
    purchase_details.map(&:total_detail).sum
  end

  def total_without_tax
    purchase_details.map(&:total_without_tax).sum
  end

end
