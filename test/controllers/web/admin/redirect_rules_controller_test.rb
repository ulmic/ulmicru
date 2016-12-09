require 'test_helper'

class Web::Admin::RedirectRulesControllerTest < ActionController::TestCase
  setup do
    @redirect_rule = create :redirect_rule
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
    get :index, search: @redirect_rule.old_path
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    RedirectRule.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create redirect_rule' do
    attributes = attributes_for :redirect_rule
    post :create, redirect_rule: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_redirect_rules_path
    redirect_rule = RedirectRule.last
    redirect_rule.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], redirect_rule.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @redirect_rule
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :redirect_rule
    patch :update, redirect_rule: attributes, id: @redirect_rule
    assert_response :redirect, @response.body
    assert_redirected_to admin_redirect_rules_path
    @redirect_rule.reload
    @redirect_rule.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @redirect_rule.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @redirect_rule
    @redirect_rule.reload
    assert @redirect_rule.removed?
  end
end
