require 'test_helper'

class CheckSubscriptionsTokenTest < ActionController::TestCase
  test 'check all tokens for deliveries subscribed' do
    users = User.subscribed_to_deliveries.with_email
    count = users.count
    users.each_with_index do |user, index|
      print "#{index} of #{count}\r"
      assert user.subscribe_token
    end
  end
end
