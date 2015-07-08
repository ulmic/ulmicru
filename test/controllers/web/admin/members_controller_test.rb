require 'test_helper'

class Web::Admin::MembersControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @member = create :member
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create member' do
    attributes = attributes_for :member
    attributes[:positions_attributes] ||= {}
    attributes[:positions_attributes]['0'] = attributes_for :position
    post :create, member: attributes
    assert_redirected_to admin_members_path
    assert_equal attributes[:patronymic], Member.last.patronymic
  end

  test 'should get edit' do
    get :edit, id: @member
    assert_response :success, @response.body

    @member.unavail
    get :edit, id: @member
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :member
    attributes[:positions_attributes] ||= {}
    attributes[:positions_attributes]['0'] = attributes_for :position
    patch :update, member: attributes, id: @member
    assert_redirected_to admin_members_path
    @member.reload
    assert_equal attributes[:patronymic], @member.patronymic
  end

  test 'should delete destroy' do
    delete :destroy, id: @member
    @member.reload
    assert @member.removed?
  end
end
