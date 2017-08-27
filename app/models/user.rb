# User model
class User
  include Mongoid::Document
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :first_name,         type: String, default: ""
  field :last_name,          type: String, default: ""
  field :phone,              type: String, default: ""
  field :address,            type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # == Asociaciones
  has_many :clients
  has_many :providers
  has_many :stores
  has_many :sales
  has_many :purchases
  has_many :stocks
  has_many :products
  has_many :dispatchs

  belongs_to :store

  # == Métodos
  def full_name
    first_name.present? ? "#{first_name} #{last_name}" : email
  end

  def role
    return 'Dios' if has_role? :god
    return 'Admin' if has_role? :admin
    return 'Seller' if has_role? :seller
  end

  def label_role
    return 'primary' if has_role? :god
    return 'success' if has_role? :admin
    return 'info' if has_role? :seller
  end
end
