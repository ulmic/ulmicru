require 'test_helper'

class Web::UsersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create user' do
    attributes = attributes_for :user
    post :create, user: attributes
    assert_response :redirect, @response.body
    assert_redirected_to account_path
    assert_equal attributes[:email], User.last.email
  end

  test 'should create subscription and token' do
    attributes = attributes_for :user
    post :create, user: attributes
    subscription = Subscription.last
    user = User.last
    assert_equal user.id, subscription.receiver_id
    assert_equal 'User', subscription.receiver_type
    assert_equal 'deliveries', subscription.subscription_type
    token = Token.last
    assert_equal subscription.id, token.record_id
    assert_equal 'Subscription', token.record_type
  end
end
