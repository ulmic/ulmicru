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
                    allow_blank: true
  validates :first_name, human_name: true,
                         allow_blank: true
  validates :last_name, human_name: true,
                         allow_blank: true

  mount_uploader :avatar, AvatarUploader

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
    state :updated
    state :corrupted_email

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
    event :set_corrupted_email do
      transition all => :corrupted_email
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
end
