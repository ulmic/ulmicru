require 'test_helper'

class Web::Admin::QuestionariesControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :member
    @questionary = create :questionary
  end

  test 'should get index' do
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
    assert_equal attributes[:patronymic], Questionary.last.patronymic
  end

  test 'should get edit' do
    get :edit, id: @questionary
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :questionary
    patch :update, questionary: attributes, id: @questionary
    assert_response :redirect, @response.body
    assert_redirected_to admin_questionaries_path
    @questionary.reload
    assert_equal attributes[:patronymic], @questionary.patronymic
  end

  test 'should delete destroy' do
    count = Questionary.count
    delete :destroy, id: @questionary
    @questionary.reload
    assert @questionary.removed?
  end
end
