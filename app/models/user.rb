class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :authentications, dependent: :destroy
  has_many :article

  validates :email, uniqueness: true,
                    allow_nil: true
  validates :first_name, human_name: true,
                         allow_blank: true
  validates :last_name, human_name: true,
                         allow_blank: true

  extend Enumerize
  enumerize :role, in: [ :user, :admin, :author ], default: :user

  include UserScopes
  include Concerns::AvatarManagment
  include Concerns::SexManagment

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

  def is_member?
    model_name == 'Member'
  end

  def is_questionary?
    model_name == 'Questionary'
  end

  def is_user?
    model_name == 'User'
  end

  def generate_token
    self.token = SecureHelper.generate_token
  end
end
