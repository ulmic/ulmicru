require 'test_helper'

class Web::Admin::ActivityLines::Corporative::MeritsControllerTest < ActionController::TestCase
  setup do
    @merit = create :activity_lines_corporative_merit
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'date']
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
    get :index, search: @merit.year
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    ::ActivityLines::Corporative::Merit.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create merit' do
    attributes = attributes_for :activity_lines_corporative_merit
    post :create, activity_lines_corporative_merit: attributes
    merit = ::ActivityLines::Corporative::Merit.last
    assert_response :redirect, @response.body
    assert_redirected_to admin_activity_lines_corporative_merits_path
    merit = ::ActivityLines::Corporative::Merit.last
    merit.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], merit.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @merit
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :activity_lines_corporative_merit
    patch :update, activity_lines_corporative_merit: attributes, id: @merit
    assert_response :redirect, @response.body
    assert_redirected_to admin_activity_lines_corporative_merit_path @merit
    @merit.reload
    @merit.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @merit.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @merit
    @merit.reload
    assert @merit.removed?
  end
end
