class User < ActiveRecord::Base
  has_secure_password validations: false
  attr_accessor :password_confirmation
  validates :password, right_confirmation: true,
                       length: {
                         allow_nil: true,
                         in: 8..ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
                       }

  has_many :authentications, dependent: :destroy
  has_many :article
  has_many :registrations, class_name: 'Event::Registration',
                           foreign_key: :user_id,
                           dependent: :destroy
  has_many :logged_actions
  has_many :subscriptions, as: :receiver, dependent: :destroy
  has_and_belongs_to_many :teams

  validates :email, email: true,
                    allow_blank: true
  validates :first_name, human_name: true,
                         allow_blank: true
  validates :last_name, human_name: true,
                         allow_blank: true
  has_many :comments, dependent: :destroy

  extend Enumerize
  enumerize :role, in: [ :user, :admin, :author, :tech_admin ], default: :user

  include AvatarManagment
  include Concerns::SexManagment
  include Concerns::ActionLoggerManagment

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :declined
    state :removed
    state :unavailable

    event :renew do
      transition all => :unviewed
    end
    event :confirm do
      transition all => :confirmed
    end
    event :decline do
      transition all => :declined
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition :removed => :unviewed
    end
  end

  def is_member?
    model_name == 'Member'
  end

  def is_questionary?
    model_name == 'Questionary'
  end

  def is_user?
    model_name == 'User'
  end

  def is_active?
    state == 'confirmed'
  end

  def admin?
    role.admin? || role.tech_admin?
  end

  def has_access?
    !removed? && !declined?
  end

  def can_reset_password?
    has_access?
  end

  def generate_token
    self.token = SecureHelper.generate_token
  end

  def subscribe_token(subscription = nil)
    subscription ||= :deliveries
    subscriptions.where(subscription_type: subscription).first.token
  end

  include PgSearch
  pg_search_scope :search_everywhere, against: [:email, :first_name, :last_name]

  def has_permission_to?(action, type)
    Organization::Permissions.send(type)[action].map(&:id).include? self.id
  end
end
