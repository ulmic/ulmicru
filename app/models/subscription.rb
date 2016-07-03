class Subscription < ActiveRecord::Base
  belongs_to :receiver, polymorphic: true

  has_one :token, as: :record

  extend Enumerize
  enumerize :subscription_type, in: [ :deliveries ]
end
