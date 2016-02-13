class Delivery::ContactEmail < ActiveRecord::Base
  validates :email, presence: true,
		    email: true
  validates :first_name, human_name: true
  validates :last_name, human_name: true
end
