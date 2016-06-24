class Delivery::ContactEmail < ActiveRecord::Base
  has_one :subscribe_token, class_name: 'Token', as: :record

  validates :email, presence: true,
		    email: true,
		    uniqueness: true
  validate :email_application_uniqueness
  validates :first_name, human_name: true
  validates :last_name, human_name: true

  state_machine :state, initial: :subscribed do
    state :subscribed
    state :unsubscribed

    event :subscribe do
      transition all => :subscribed
    end

    event :unsubscribe do
      transition all => :unsubscribed
    end
  end

  private

  def email_application_uniqueness
    if User.find_by_email(email).present?
      errors.add :email, I18n.t('validations.errors.email_presents_in_application')
    end
  end
end
