require 'test_helper'

class Web::Users::AccountControllerTest < ActionController::TestCase
  setup do
    @member = create :member
    sign_in @member
  end

  test 'should get index' do
    current_user.update_attributes! questionary_state: :not_existed
    get :index
    assert_response :success, @response.body
  end

  test 'should patch update with user' do
    attributes = attributes_for :user
    patch :update, user: attributes, id: @member
    assert_response :redirect, @response.body
    assert_redirected_to account_path
    @member.reload
    assert_equal attributes[:first_name], @member.first_name
  end

  test 'should patch update with member' do
    attributes = attributes_for :member
    patch :update, member: attributes, id: @member
    assert_response :redirect, @response.body
    assert_redirected_to account_path
    @member.reload
    assert_equal attributes[:patronymic], @member.patronymic
  end
end
