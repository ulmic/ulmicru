class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :authentications

  validates :email, uniqueness: true

  extend Enumerize
  enumerize :role, in: [ :user, :admin ], default: :user

  scope :admins, -> { where role: :admin }
end
