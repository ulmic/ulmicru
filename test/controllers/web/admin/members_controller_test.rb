require 'test_helper'

class Web::Admin::MembersControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @member = create :member
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'password_digest', 'avatar', 'birth_date', 'user_id']
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @member.first_name
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Member.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      MemberDecorator.collections.each do |collection|
        pages = Member.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
          print "Page #{page} of #{pages} of #{collection}\r"
        end
      end
    end
  end

  test 'should get show' do
    get :show, id: @member
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
      assert_equal attributes[key.to_sym].to_s, member.send(key).to_s, key
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
    assert_redirected_to admin_member_path @member
    @member.reload
    @member.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym].to_s, @member.send(key).to_s, key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @member
    @member.reload
    assert @member.removed?
  end
end
