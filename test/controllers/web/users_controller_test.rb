require 'test_helper'

class Web::UsersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    create :article, :contacts
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
end
