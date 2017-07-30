class Delivery::ContactEmail < ActiveRecord::Base
  has_one :subscribe_token, class_name: 'Token', as: :record
  has_many :subscriptions, as: :receiver, dependent: :destroy

  validates :email, presence: true,
		    email: true,
		    uniqueness: true
  validate :email_application_uniqueness
  validates :first_name, human_name: true, allow_blank: true
  validates :last_name, human_name: true, allow_blank: true

  state_machine :state, initial: :active do
    state :not_active
    state :active
    state :removed

    event :restore do
      transition all => :active
    end

    event :confirm do
      transition not_active: :active
    end

    event :remove do
      transition all => :removed
    end
  end

  include StateMachine::Scopes
  scope :subscribed_to_deliveries, -> { presented.joins(:subscriptions).where 'subscriptions.subscription_type = ?', :deliveries }
  scope :with_email, -> { presented.where.not email: nil }
  scope :presented, -> { active }

  include PgSearch
  pg_search_scope :search, against: [ :email, :first_name, :last_name ]

  private

  def email_application_uniqueness
    if User.find_by_email(email).present?
      errors.add :email, I18n.t('validations.errors.email_presents_in_application')
    end
  end
end
