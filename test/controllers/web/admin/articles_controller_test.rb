require 'test_helper'

class Web::Admin::ArticlesControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @category = create :category
    @article = create :article
  end

  test "should get index" do
    get :index
    assert_response :success, @response.body
  end

  test "should get new" do
    get :new
    assert_response :success, @response.body
  end

  test "should create article" do
    attributes = attributes_for :article
    post :create, article: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_articles_path
    assert_equal attributes[:body], Article.last.body
  end
  
  test "should not create article" do
    attributes = { body: @article.body }
    post :create, article: attributes
    assert_response :success
  end

  test "should get edit by admin" do
    get :edit, id: @article
    assert_response :success
  end

  test "should update category by admin" do
    attributes = attributes_for :article
    put :update, id: @article, article: attributes
    assert_response :redirect
    @article.reload
    assert_equal attributes[:title], @article.title
  end

  test "should not update adticle by admin" do
    attributes = attributes_for :article
    attributes[:title] = nil
    count_before_save = Article.count
    put :update, id: @article, article: attributes
    assert_equal Article.count, count_before_save
    assert_response :success
  end

  test "should destroy category" do
    count =  Article.count
    delete :destroy, id: @article 
    @article.reload
    assert @article.removed?
  end
end
