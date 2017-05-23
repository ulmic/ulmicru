require 'test_helper'

class Web::Admin::VideosControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @video = create :video
    @exceptions_attributes = ['id', 'created_at', 'updated_at']
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @video.title
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      VideoDecorator.collections.each do |collection|
        pages = Video.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
          print "Page #{page} of #{pages} of #{collection}\r"
        end
      end
    end
  end

  test 'should get index without instances' do
    Video.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create video' do
    attributes = attributes_for :video
    attributes[:user_id] = current_user.id
    post :create, video: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_videos_path
    video = Video.where(title: attributes[:title]).first
    video.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], video.send(key), key
    end
  end

  test 'should not create video' do
    attributes = { title: @video.title }
    post :create, video: attributes
    assert_response :success
  end

  test 'should get edit by admin' do
    get :edit, id: @video
    assert_response :success
  end

  test 'should update video by admin' do
    attributes = attributes_for :video
    put :update, id: @video, video: attributes
    assert_response :redirect
    assert_redirected_to edit_admin_video_path @video
    @video.reload
    @video.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @video.send(key), key
    end
  end

  test 'should not update video by admin' do
    attributes = attributes_for :video
    attributes[:title] = nil
    count_before_save = Video.count
    put :update, id: @video, video: attributes
    assert_equal Video.count, count_before_save
    assert_response :success
  end

  test 'should destroy video' do
    count =  Video.count
    delete :destroy, id: @video
    @video.reload
    assert @video.removed?
  end
end
