class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :authentications

  validates :email, uniqueness: true,
                    allow_nil: true
  validates :first_name, human_name: true,
                         allow_blank: true
  validates :last_name, human_name: true,
                         allow_blank: true

  extend Enumerize
  enumerize :role, in: [ :user, :admin ], default: :user

  scope :admins, -> { where role: :admin }

  scope :presented, -> { where.not(state: :removed) }
  scope :removed, -> { where state: :removed }

  state_machine :state, initial: :unviewed do
    state :unviewed
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
    event :restore do
      transition :removed => :unviewed
    end
  end
end
