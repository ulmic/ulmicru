require 'test_helper'

class Api::Users::Account::SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test 'should create subscription' do
    attributes = attributes_for :subscription
    post :create, subscription: attributes
    assert_response :success
    subscription = Subscription.last
    assert_equal subscription.receiver_id, @user.id
    assert_equal subscription.receiver_type, 'User'
  end

  test 'should delete subscription' do
    subscription = create :subscription, receiver_id: @user.id, receiver_type: 'User'
    count = Subscription.count
    delete :destroy, subscription: { subscription_type: subscription.subscription_type }
    assert_equal count - 1, Subscription.count
  end
end
