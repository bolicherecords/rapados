class Sale

  # == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
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


  # == Validaciones
  validates_presence_of :total, message: "Debes ingresar un total."

  # == Métodos
  def finish
    if self.status == STATUS_DRAFT
      self.status = STATUS_FINISHED
      self.finish_at = Time.now
      self.save
      #TODO: Call to update stock service
      #StockControlService.execute(self, 'SALE')
    end
  end

  def cancel
    if self.status < STATUS_CANCELLED
      self.status = STATUS_CANCELLED
      self.cancel_at = Time.now
      self.save
      #TODO: Call to update stock service
    end
  end

  def is_draft?
    self.status == STATUS_DRAFT
  end
end
