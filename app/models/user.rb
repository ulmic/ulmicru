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
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :teams
  has_many :merits, class_name: 'ActivityLines::Corporative::Merit'
  has_many :ya_lider_participants, class_name: 'ActivityLines::Lider::YaLider::Participant'
  has_many :tokens, as: :record

  validates :email, email: true,
                    allow_blank: true,
                    uniqueness: true,
                    allow_nil: true
  validates :first_name, human_name: true,
                         allow_blank: true
  validates :last_name, human_name: true,
                         allow_blank: true

  mount_uploader :avatar, AvatarUploader

  extend Enumerize
  enumerize :role, in: [ :user, :admin, :author, :tech_admin ], default: :user
  enumerize :gender, in: [ :male, :female ]

  include AvatarManagment
  include Concerns::SexManagment
  include Concerns::ActionLoggerManagment

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :declined
    state :removed
    state :unavailable
    state :updated

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

  state_machine :questionary_state, initial: :not_existed do
    state :not_existed
    state :step_1
    state :step_2
    state :done

    event :to_step_1 do
      transition not_existed: :step_1
    end

    event :to_step_2 do
      transition step_1: :step_2
    end

    event :finish do
      transition step_2: :done
    end

    event :remove_questionary do
      transition all => :not_existed
    end
  end

  state_machine :email_state, initial: :active, namespace: :email do
    state :active
    state :corrupted

    event :set_corrupted do
      transition all => :corrupted
    end
    event :set_active do
      transition all => :active
    end
  end

  include StateMachine::Scopes

  scope :admins, -> { where role: :admin }
  scope :presented, -> { where.not(state: :removed).order('id DESC') }
  scope :unviewed, -> { where(state: :unviewed, type: nil).where.not(email: nil).order('id DESC') }
  scope :subscribed_to_deliveries, -> { joins(:subscriptions).where 'subscriptions.subscription_type = ?', :deliveries }
  scope :with_email, -> { where.not(email: nil, email_state: :corrupted).where.not(email: "") }
  scope :without_current_positions, -> do
    where.not(id: Position.current_positions.map(&:member_id).uniq)
  end
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
  scope :just_users, -> { where type: nil }
  scope :just_members, -> { where type: 'Member' }
  scope :just_questionaries, -> { where type: 'Questionary' }
  scope :tech_admins, -> { where role: :tech_admin }
  scope :authors, -> { where role: :author }

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

  def subscribe_token(subscription = :deliveries)
    subscriptions.where(subscription_type: subscription).first.token
  end

  include Concerns::Searchable
  search_against :email, :first_name, :last_name

  def has_permission_to?(action, type)
    Organization::Permissions.send(type)[action].map(&:id).include? self.id
  end

  def as_record_logged_actions
    LoggedAction.where record_id: id, record_type: self.class
  end

  def current_ya_lider_participant
    ::ActivityLines::Lider::YaLider.current_contest.current_stage.participants.where(user_id: id).first
  end

  def is_ya_lider_participant?
    current_contest = ::ActivityLines::Lider::YaLider.current_contest
    if current_contest.present? && current_contest.current_stage.present?
      current_contest.current_stage.participants.map(&:user_id).include? id
    end
  end

  def self.collections
    [ :confirmed, :unviewed, :admins, :authors, :declined, :email_corrupted ]
  end

  def set_gender!
    update_attributes gender: GenderHelper.detect_gender(first_name)
  end

  def user_type
    'User'
  end
end
