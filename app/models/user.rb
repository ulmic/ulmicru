class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :email, presence: true
end
