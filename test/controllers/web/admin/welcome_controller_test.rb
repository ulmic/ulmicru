require 'test_helper'

class Web::Admin::WelcomeControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end
end
