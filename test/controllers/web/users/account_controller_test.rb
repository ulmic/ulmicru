require 'test_helper'

class Web::Users::AccountControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end
end
