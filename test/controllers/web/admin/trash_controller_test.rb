require 'test_helper'

class Web::Admin::TrashControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    @user.remove
  end
  test 'should get index' do
    get :index, type: :user
    assert_response :success, @response.body
  end

  test 'should patch restore' do
    patch :restore, type: :user, id: @user
    @user.reload
    assert @user.not_confirmed?
    assert_response :redirect, @response.body
  end

  test 'should delete destroy' do
    count = User.count
    delete :destroy, type: :user, id: @user
    assert_equal count - 1, User.count
    assert_response :redirect, @response.body
  end
end
