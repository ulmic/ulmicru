require 'test_helper'

class Api::CommentsControllerTest < ActionController::TestCase
  setup do
    user = create :user
    @comment = create :comment
    sign_in user
  end

  test 'should get index' do
    create_list :comment, 5
    get :index, record_type: @comment.record_type, record_id: @comment.record_id
    assert_response :success
  end

  test 'should post create' do
    count = Comment.count
    attributes = attributes_for :comment
    post :create, comment: attributes
    assert_response :success, @response.body
    assert_equal count + 1, Comment.count
    assert_equal Comment.last.text, attributes[:text]
  end

  test 'should delete destroy' do
    comment = create :comment, user: current_user, state: :active
    active_comments = Comment.published.count
    delete :destroy, id: comment
    assert_response :success
    assert_equal active_comments - 1, Comment.published.count
  end
end
