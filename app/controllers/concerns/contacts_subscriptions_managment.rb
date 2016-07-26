module Concerns
  module ContactsSubscriptionsManagment
    def initialize_subscriptions(receiver)
      ::Delivery::ContactEmail.where(email: receiver.email).first&.destroy
      subscription = Subscription.create! receiver_id: receiver.id, 
        receiver_type: receiver.class.name, 
        subscription_type: :deliveries
      Token.create! record_id: subscription.id,
        record_type: 'Subscription',
        content: SecureHelper.generate_token
    end
  end
end
