require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @category = create :category
  end

  test "should get index" do
    get :index
    assert_response :success, @response.body
  end

  test "should get new" do
    get :new
    assert_response :success, @response.body
  end

  test "should create category" do
    attributes = attributes_for :category
    post :create, category: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_categories_path
    assert_equal attributes[:name], Category.last.name
  end

  test "should not create category" do
    attributes = { name: nil }
    post :create, category: attributes
    assert_response :success
  end

  test "should get edit by admin" do
    get :edit, id: @category
    assert_response :success
  end

  test "should update category by admin" do
    attributes = attributes_for :category
    put :update, id: @category, category: attributes
    assert_response :redirect
    assert_redirected_to edit_admin_category_path @category
    @category.reload
    assert_equal attributes[:name], @category.name
  end

  test "should not update adticle by admin" do
    attributes = attributes_for :category
    attributes[:name] = nil
    count_before_save = Category.count
    put :update, id: @category, category: attributes
    assert_equal Category.count, count_before_save
    assert_response :success
  end

  test "should destroy category" do
    count =  Category.count
    delete :destroy, id: @category
    @category.reload
    assert @category.removed?
  end
end
