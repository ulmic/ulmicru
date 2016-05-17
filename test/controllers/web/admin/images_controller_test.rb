require 'test_helper'

class Web::Admin::ImagesControllerTest < ActionController::TestCase
  setup do
    @image = create :image
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'date', 'file']
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
    get :index, search: @image.slug
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Image.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create image' do
    attributes = attributes_for :image
    post :create, image: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_images_path
    image = Image.last
    image.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], image.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @image
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :image
    patch :update, image: attributes, id: @image
    assert_response :redirect, @response.body
    assert_redirected_to edit_admin_image_path @image
    @image.reload
    @image.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @image.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @image
    @image.reload
    assert @image.removed?
  end
end
