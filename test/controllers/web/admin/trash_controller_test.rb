require 'test_helper'

class Web::Admin::TrashControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    @user.remove
    @member = create :member
    @member.remove
    @questionary = create :questionary
    @questionary.remove
  end
  test 'should get index' do
    get :index, type: :user
    assert_response :success, @response.body
    get :index, type: :member
    assert_response :success, @response.body
    get :index, type: :questionary
    assert_response :success, @response.body
  end

  test 'should patch restore' do
    patch :restore, type: :user, id: @user
    @user.reload
    assert @user.unviewed?
    assert_response :redirect, @response.body
  end

  test 'should delete destroy' do
    count = User.count
    delete :destroy, type: :user, id: @user
    assert_equal count - 1, User.count
    assert_response :redirect, @response.body
  end
end
