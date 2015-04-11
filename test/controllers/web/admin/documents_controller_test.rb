require 'test_helper'

class Web::Admin::DocumentsControllerTest < ActionController::TestCase
  setup do
    @document = create :document
    admin = create :admin
    sign_in admin
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should create document' do
    attributes = attributes_for :document
    post :create, document: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_documents_path
    assert_equal attributes[:title], Document.last.title
  end

  test 'should get edit' do
    get :edit, id: @document
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :document
    patch :update, document: attributes, id: @document
    assert_response :redirect, @response.body
    assert_redirected_to admin_documents_path
    @document.reload
    assert_equal attributes[:title], @document.title
  end

  test 'should delete destroy' do
    delete :destroy, id: @document
    @document.reload
    assert @document.removed?
  end
end
