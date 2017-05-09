FactoryGirl.define do
  factory :subscription do
    receiver_type { Subscription.receiver_type.values.sample }
    receiver_id { receiver_type.constantize.last&.id || create(receiver_type.underscore) }
    subscription_type { Subscription.subscription_type.values.sample }
  end
end
