class Delivery::ContactEmailForm < ApplicationReform
  properties :email, :first_name, :last_name, :state

  validates :first_name, presence: true
  validates :last_name, presence: true
end
