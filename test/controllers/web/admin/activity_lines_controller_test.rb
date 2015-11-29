require 'test_helper'

class Web::Admin::ActivityLinesControllerTest < ActionController::TestCase
  setup do
    @activity_line = create :activity_line
    admin = create :admin
    sign_in admin
    @exceptions_attributes = [ 'id', 'created_at', 'updated_at', 'found_date', 'logo' ]
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @activity_line.title
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    ActivityLine.all.map &:destroy
    get :index
    assert_response :success, @response.body
  end

  test 'should create activity_line' do
    attributes = attributes_for :activity_line
    post :create, activity_line: attributes
    assert_redirected_to admin_activity_lines_path
    activity_line = ActivityLine.last
    activity_line.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], activity_line.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @activity_line
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :activity_line
    patch :update, activity_line: attributes, id: @activity_line
    assert_redirected_to edit_admin_activity_line_path @activity_line
    @activity_line.reload
    @activity_line.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @activity_line.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @activity_line
    @activity_line.reload
    assert @activity_line.removed?
  end

end
