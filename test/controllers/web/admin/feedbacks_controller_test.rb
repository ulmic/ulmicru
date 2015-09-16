require 'test_helper'

class Web::Admin::FeedbacksControllerTest < ActionController::TestCase
  setup do
    @feedback = create :feedback
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

  test 'should get index without instances' do
    Feedback.all.map &:destroy
    get :index
    assert_response :success, @response.body
  end

  test 'should create feedback' do
    attributes = attributes_for :feedback
    post :create, feedback: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_feedbacks_path
    feedback = Feedback.last
    feedback.attributes.keys.except('id', 'created_at', 'updated_at').each do |key|
      assert_equal attributes[key.to_sym], feedback.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @feedback
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :feedback
    patch :update, feedback: attributes, id: @feedback
    assert_response :redirect, @response.body
    assert_redirected_to edit_admin_feedback_path @feedback
    @feedback.reload
    @feedback.attributes.keys.except('id', 'created_at', 'updated_at').each do |key|
      assert_equal attributes[key.to_sym], @feedback.send(key), key
    end
  end

  test 'should delete destroy' do
    count = Feedback.count
    delete :destroy, id: @feedback
    assert_equal count - 1, Feedback.count
  end
end
