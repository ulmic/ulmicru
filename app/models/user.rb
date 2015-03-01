class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :authentications

  validates :email, uniqueness: true

  extend Enumerize
  enumerize :role, in: [ :user, :admin ], default: :user

  scope :admins, -> { where role: :admin }

  state_machine initilize: :not_confirmed do
    state :not_confirmed
    state :confirmed
    state :declined
    state :deleted

    event :confirm do
      transition all => :confirmed
    end
    event :decline do
      transition all => :declined
    end
    event :delete do
      transition all => :delete
    end
  end
end
