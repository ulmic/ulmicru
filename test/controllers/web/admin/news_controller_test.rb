require 'test_helper'

class Web::Admin::NewsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @news = create :news
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'published_at', 'photo', 'user_id']
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get index with search' do
    get :index, search: @news.title
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    News.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create news' do
    attributes = attributes_for :news
    post :create, news: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_news_index_path
    news = News.last
    news.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], news.send(key), key
    end
  end

  test 'should not create news' do
    attributes = { body: @news.body }

    post :create, news: attributes
    assert_response :success
  end

  test 'should get edit by admin' do
    get :edit, id: @news
    assert_response :success
  end

  test 'should update news by admin' do
    attributes = attributes_for :news
    put :update, id: @news, news: attributes
    assert_response :redirect
    assert_redirected_to edit_admin_news_path @news
    @news.reload
    @news.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @news.send(key), key
    end
  end

  test 'should not update news with render edit' do
    attributes = attributes_for :news
    attributes[:title] = nil
    put :update, id: @news, news: attributes

    assert_response :success
  end

  test 'should destroy news' do
    count = News.count
    delete :destroy, id: @news
    @news.reload
    assert @news.removed?
  end
end
