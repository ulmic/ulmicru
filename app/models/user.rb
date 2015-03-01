class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :authentications

  validates :email, uniqueness: true

  extend Enumerize
  enumerize :role, in: [ :user, :admin ], default: :user

  scope :admins, -> { where role: :admin }

  state_machine :state, initial: :not_confirmed do
    state :not_confirmed
    state :confirmed
    state :declined
    state :removed

    event :confirm do
      transition all => :confirmed
    end
    event :decline do
      transition all => :declined
    end
    event :remove do
      transition all => :removed
    end
  end
end
