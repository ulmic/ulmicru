require 'test_helper'

class Web::Admin::LoggedActionsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @logged_action = create :logged_action
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: LoggedAction.first.record.id
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    LoggedAction.all.map &:destroy
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    get :show, id: @logged_action
    assert_response :success, @response.body
  end
end
