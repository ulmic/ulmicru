require 'test_helper'

class Web::Admin::LoggedActionsControllerTest < ActionController::TestCase
  setup do
    @logged_action = create :logged_action
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    LoggedAction.all.map &:destroy
    get :index
    assert_response :success, @response.body
  end
end
