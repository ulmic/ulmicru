require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    @user.generate_token
    @user.save!
    sign_in @user
  end

  test 'should confirm user' do
    get :confirm, :token => @user.token, :id => @user.id
    @user.reload
    assert_response :redirect, @response.body
    assert_equal 'confirmed', @user.state
  end

  test 'should resent email instructions' do
    old_user_token = @user.token
    get :resent_email_instructions, :token => @user.token, :id => @user.id
    @user.reload
    assert_response :redirect, @response.body
    assert_not_equal old_user_token, @user.token
  end
end
