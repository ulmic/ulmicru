require 'test_helper'

class Web::Admin::ActivityLines::Corporative::ConfessionsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @confession = create :confession
    @exceptions_attributes = ['id', 'created_at', 'updated_at']
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      ActivityLines::Corporative::ConfessionDecorator.collections.each do |collection|
        pages = ActivityLines::Corporative::Confession.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
          print "Page #{page} of #{pages} of #{collection}\r"
        end
      end
    end
  end

  test 'should get show' do
    4.times { create :argument }
    get :show, id: @confession
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @confession.year
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    ActivityLines::Corporative::Confession.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    4.times { create :argument }
    get :new
    assert_response :success, @response.body
  end

  test 'should create confession' do
    attributes = attributes_for :confession
    attributes[:arguments_attributes] = {}
    attributes[:arguments_attributes]['0'] = attributes_for :argument
    post :create, activity_lines_corporative_confession: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_activity_lines_corporative_confessions_path
    confession = ActivityLines::Corporative::Confession.last
    confession.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], confession.send(key), key
    end
  end

  test 'should not create confession' do
    attributes = { year: @confession.year }
    post :create, activity_lines_corporative_confession: attributes
    assert_response :success
  end

  test 'should get edit by admin' do
    4.times { create :argument }
    get :edit, id: @confession
    assert_response :success
  end

  test 'should update confession by admin' do
    attributes = attributes_for :confession
    put :update, id: @confession, activity_lines_corporative_confession: attributes
    assert_response :redirect
    assert_redirected_to edit_admin_activity_lines_corporative_confession_path @confession
    @confession.reload
    @confession.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @confession.send(key), key
    end
  end

  test 'should not update confession by admin' do
    attributes = attributes_for :confession
    attributes[:year] = nil
    count_before_save = ActivityLines::Corporative::Confession.count
    put :update, id: @confession, activity_lines_corporative_confession: attributes
    assert_equal ActivityLines::Corporative::Confession.count, count_before_save
    assert_response :success
  end

  test 'should destroy confession' do
    count =  ActivityLines::Corporative::Confession.count
    delete :destroy, id: @confession
    @confession.reload
    assert @confession.removed?
  end
end
