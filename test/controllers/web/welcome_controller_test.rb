require 'test_helper'

class Web::WelcomeControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with auth' do
    sign_in create :user
    get :index
    assert_response :success, @response.body
  end
end
