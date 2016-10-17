require 'test_helper'

class Web::Admin::QuestionariesControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :member
    @questionary = create :questionary
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'password_digest', 'birth_date', 'avatar']
    create :position, title: 'Руководитель корпоративных проектов', for_now: 1
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @questionary.first_name
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Questionary.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create questionary' do
    attributes = attributes_for :questionary
    post :create, questionary: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_questionaries_path
    questionary = Questionary.last
    questionary.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], questionary.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @questionary
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :questionary
    patch :update, questionary: attributes, id: @questionary
    assert_response :redirect, @response.body
    assert_redirected_to edit_admin_questionary_path @questionary
    @questionary.reload
    @questionary.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @questionary.send(key), key
    end
  end

  test 'should delete destroy' do
    count = Questionary.count
    delete :destroy, id: @questionary
    @questionary.reload
    assert @questionary.removed?
  end
end
