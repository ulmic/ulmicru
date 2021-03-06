require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @user = create :user
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'gender', 'password_digest', 'avatar']
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @user.first_name
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      UserDecorator.collections.each do |collection|
        pages = User.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
          print "Page #{page} of #{pages} of #{collection}\r"
        end
      end
    end
  end

  test 'should create user' do
    attributes = attributes_for :user
    post :create, user: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_users_path
    user = User.last
    user.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], user.send(key), key
    end
    assert_equal GenderHelper.detect_gender(user.first_name).to_s, user.gender
  end

  test 'should get edit' do
    get :edit, id: @user
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :user
    attributes[:first_name] = 'Dima'
    patch :update, user: attributes, id: @user
    assert_response :redirect, @response.body
    assert_redirected_to admin_users_path
    @user.reload
    @user.attributes.keys.except('id', 'created_at', 'updated_at', 'password_digest', 'avatar').each do |key|
      assert_equal attributes[key.to_sym], @user.send(key), key
    end
  end

  test 'should delete destroy' do
    count = User.count
    delete :destroy, id: @user
    @user.reload
    assert @user.removed?
  end
end
