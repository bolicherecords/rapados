require 'barby'
require 'barby/barcode/ean_13'
require 'barby/barcode/code_128'
require 'barby/outputter/html_outputter'
require 'barby/outputter/png_outputter'

class Product

	# == Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Mongoid::Paranoia
  # include GlobalID::Identification

  # == Asociaciones
  has_many    :sale_details
  has_many    :purchase_details
  has_many    :dispatch_details
  has_many    :stocks, dependent: :destroy
  belongs_to  :user

  STATUS_DESACTIVATE = 0
  STATUS_ACTIVATE    = 1

  # == Atributos
  field :name,            type: String, default: ''
  field :description,     type: String, default: ''
  field :unit,            type: String, default: ''
  field :code,            type: Integer, default: ''
  field :sale_price,      type: Integer, default: 0
  field :barcode,         type: String, default: ''
  field :status,          type: Integer, default: STATUS_ACTIVATE
  field :extra,           type: Float  , default: 0

  before_create :set_code, :set_barcode

  # == Validaciones
  validates_presence_of :name, message: 'Debes ingresar un nombre.'

  # == Buscador
  search_in :name, :description, :unit, :barcode

  # == Métodos
  def purchases
    Purchase.in(id: purchase_details.pluck(:pucharse_id))
  end

  def set_code
    begin
      code = Product.count > 0 ? Product.last.code + 1 : 1
      self.code = code
    end while Product.where(code: code).present?
  end

  def get_stocks
    stocks.distinct(:store).map{|s| Stock.current_stock(self, s)}
  end

  def get_extra
    extra/100
  end

  def set_barcode
    begin
      self.barcode = Barby::EAN13.new(format('%012d', code)).data.to_s
    end while Product.where(barcode: barcode).present?
  end

  def full_name
    "(#{barcode}) #{name}"
  end

  # def profit_margin
  #   sale_price - (purchase_price + purchase_price * get_extra)
  # end

end
