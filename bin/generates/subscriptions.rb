count  = Delivery::ContactEmail.count + User.count
[Delivery::ContactEmail, User].each do |receivers|
  receivers.find_each.with_index do |receiver, index|
    s = Subscription.create! subscription_type: :deliveries, receiver_id: receiver.id, receiver_type: receivers.name.to_s
    Token.create! content: SecureHelper.generate_token, record_id: s.id, record_type: 'Subscription'
    index += Delivery::ContactEmail.count if receivers == User
    print "#{index} of #{count}\r"
  end
end
