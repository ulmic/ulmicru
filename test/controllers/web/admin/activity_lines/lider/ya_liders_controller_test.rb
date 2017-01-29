require 'test_helper'

class Web::Admin::ActivityLines::Lider::YaLidersControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @ya_lider = create :ya_lider
    @exceptions_attributes = ['id', 'created_at', 'updated_at']
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    4.times { create :argument }
    get :show, id: @ya_lider
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      ActivityLines::Lider::YaLiderDecorator.collections.each do |collection|
        pages = ActivityLines::Lider::YaLider.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
        end
      end
    end
  end

  test 'should get index with search' do
    get :index, search: @ya_lider.contest_year
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    ActivityLines::Lider::YaLider.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    4.times { create :argument }
    get :new
    assert_response :success, @response.body
  end

  test 'should create ya_lider' do
    attributes = attributes_for :ya_lider
    attributes[:arguments_attributes] = {}
    attributes[:arguments_attributes]['0'] = attributes_for :argument
    post :create, activity_lines_lider_ya_lider: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_activity_lines_lider_ya_liders_path
    ya_lider = ActivityLines::Lider::YaLider.last
    ya_lider.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], ya_lider.send(key), key
    end
  end

  test 'should not create ya_lider' do
    attributes = { contest_year: @ya_lider.contest_year }
    post :create, activity_lines_lider_ya_lider: attributes
    assert_response :success
  end

  test 'should get edit by admin' do
    4.times { create :argument }
    get :edit, id: @ya_lider
    assert_response :success
  end

  test 'should update ya_lider by admin' do
    attributes = attributes_for :ya_lider
    put :update, id: @ya_lider, activity_lines_lider_ya_lider: attributes
    assert_response :redirect
    assert_redirected_to edit_admin_activity_lines_lider_ya_lider_path @ya_lider
    @ya_lider.reload
    @ya_lider.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @ya_lider.send(key), key
    end
  end

  test 'should not update ya_lider by admin' do
    attributes = attributes_for :ya_lider
    attributes[:contest_year] = nil
    count_before_save = ActivityLines::Lider::YaLider.count
    put :update, id: @ya_lider, activity_lines_lider_ya_lider: attributes
    assert_equal ActivityLines::Lider::YaLider.count, count_before_save
    assert_response :success
  end

  test 'should destroy ya_lider' do
    delete :destroy, id: @ya_lider
    @ya_lider.reload
    assert @ya_lider.removed?
  end
end
