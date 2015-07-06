require 'test_helper'

class Web::Admin::CommentsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @comment = create :comment
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create comment' do
    attributes = attributes_for :comment
    post :create, comment: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_comments_path
    assert_equal attributes[:text], Comment.last.text
  end

  test 'should get edit' do
    get :edit, id: @comment
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :comment
    patch :update, comment: attributes, id: @comment
    assert_response :redirect, @response.body
    assert_redirected_to admin_comments_path
    @comment.reload
    assert_equal attributes[:text], @comment.text
  end

  test 'should delete destroy' do
    count = Comment.count
    delete :destroy, id: @comment
    assert_equal count - 1, Comment.count
  end
end
