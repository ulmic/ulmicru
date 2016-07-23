class Delivery::ContactEmail < ActiveRecord::Base
  has_one :subscribe_token, class_name: 'Token', as: :record

  validates :email, presence: true,
		    email: true,
		    uniqueness: true
  validate :email_application_uniqueness
  validates :first_name, human_name: true
  validates :last_name, human_name: true

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :restore do
      transition all => :active
    end

    event :remove do
      transition all => :removed
    end
  end

  include PgSearch
  pg_search_scope :search, against: [ :email, :first_name, :last_name ]

  private

  def email_application_uniqueness
    if User.find_by_email(email).present?
      errors.add :email, I18n.t('validations.errors.email_presents_in_application')
    end
  end
end
