require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
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
    assert_redirected_to admin_users_path
    assert_equal attributes[:email], User.last.email
  end

  test 'should get edit' do
    get :edit, id: @user
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :user
    patch :update, user: attributes, id: @user
    assert_response :redirect, @response.body
    assert_redirected_to admin_users_path
    @user.reload
    assert_equal attributes[:email], @user.email
  end

  test 'should delete destroy' do
    count = User.count
    delete :destroy, id: @user
    assert_equal count - 1, User.count
  end
end
