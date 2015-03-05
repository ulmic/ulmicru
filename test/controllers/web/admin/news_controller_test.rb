require 'test_helper'

class Web::Admin::NewsControllerTest < ActionController::TestCase
  setup do
    @news = create :news
  end
  
  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    get :show, id: @news
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create news' do
    attributes = attributes_for :news
    post :create, user: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_news_index_path
    assert_equal attributes[:body], News.last.body
  end
  

end
