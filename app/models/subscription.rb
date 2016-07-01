class Subscription < ActiveRecord::Base
  has_one :token
end
