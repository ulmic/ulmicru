require 'test_helper'

class Web::MembersControllerTest < ActionController::TestCase
  setup do
    @member = create :member
    sign_in @member
  end

  test 'should not get new unsigned' do
    sign_out
    get :new
    assert_response :redirect, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create member' do
    attributes = attributes_for :member
    post :create, member: attributes
    assert_response :redirect, @response.body
    assert_redirected_to account_path
    assert_equal attributes[:patronymic], Member.last.patronymic
  end

  test 'should get show' do
    get :show, ticket: @member.ticket
    assert_response :success, @response.body
  end
end
