require 'test_helper'

class Web::Admin::MembersControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @member = create :member
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'password_digest', 'avatar', 'birth_date']
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Member.all.map &:destroy
    get :index
    assert_response :success, @response.body
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
    member = Member.last
    member.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], member.send(key), key
    end
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
    assert_redirected_to edit_admin_member_path @member
    @member.reload
    @member.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @member.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @member
    @member.reload
    assert @member.removed?
  end
end
