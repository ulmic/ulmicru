require 'test_helper'

class Web::Admin::CommentsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :news
    @comment = create :comment
    @exceptions_attributes = ['id', 'created_at', 'updated_at']
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      CommentDecorator.collections.each do |collection|
        pages = Comment.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
        end
      end
    end
  end

  test 'should get index without instances' do
    Comment.destroy_all
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
    comment = Comment.last
    comment.attributes.keys.except('id', 'created_at', 'updated_at').each do |key|
      assert_equal attributes[key.to_sym], comment.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @comment
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :comment
    patch :update, comment: attributes, id: @comment
    assert_response :redirect, @response.body
    assert_redirected_to edit_admin_comment_path @comment
    @comment.reload
    @comment.attributes.keys.except('id', 'created_at', 'updated_at').each do |key|
      assert_equal attributes[key.to_sym], @comment.send(key), key
    end
  end

  test 'should delete destroy' do
    count = Comment.count
    delete :destroy, id: @comment
    assert_equal count - 1, Comment.count
  end
end
