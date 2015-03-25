require 'test_helper'

class Web::Admin::ActivityLinesControllerTest < ActionController::TestCase
  setup do
    @activity_line = create :activity_line
    admin = create :admin
    sign_in admin
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create activity_line' do
    attributes = attributes_for :activity_line
    post :create, activity_line: attributes
    assert_redirected_to admin_activity_lines_path
    assert_equal attributes[:title], ActivityLine.last.title
  end

  test 'should get edit' do
    get :edit, id: @activity_line
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :activity_line
    patch :update, activity_line: attributes, id: @activity_line
    assert_redirected_to admin_activity_lines_path
    @activity_line.reload
    assert_equal attributes[:title], @activity_line.title
  end

  test 'should delete destroy' do
    delete :destroy, id: @activity_line
    @activity_line.reload
    assert @activity_line.removed?
  end

end
