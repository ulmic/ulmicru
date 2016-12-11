require 'test_helper'

class Web::Admin::TagsControllerTest < ActionController::TestCase
  setup do
    @tag = create :tag
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at']
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
    get :index, search: @tag.tag_type
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Tag.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create tag' do
    attributes = attributes_for :tag
    post :create, tag: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_tags_path
    tag = Tag.last
    tag.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], tag.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @tag
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :tag
    patch :update, tag: attributes, id: @tag
    assert_response :redirect, @response.body
    assert_redirected_to admin_tags_path
    @tag.reload
    @tag.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @tag.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @tag
    @tag.reload
    assert @tag.removed?
  end
end
