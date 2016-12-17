require 'test_helper'

class Web::Admin::Oauth::AppsControllerTest < ActionController::TestCase
  setup do
    @app = create :oauth_app
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'begin_date', 'end_date', 'horizontal', 'vertical']
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
    get :index, search: @app.url
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Oauth::App.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create app' do
    attributes = attributes_for :oauth_app
    post :create, oauth_app: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_oauth_apps_path
    app = Oauth::App.last
    app.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], app.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @app
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :oauth_app
    patch :update, oauth_app: attributes, id: @app
    assert_response :redirect, @response.body
    assert_redirected_to admin_oauth_apps_path
    @app.reload
    @app.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @app.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @app
    @app.reload
    assert @app.removed?
  end
end
