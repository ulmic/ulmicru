require 'test_helper'

class Web::Admin::PlacesControllerTest < ActionController::TestCase
  setup do
    @place = create :place
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at']
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
    get :index, search: @place.title
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Place.delete_all
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    get :show, id: @place
    assert_response :success
  end

  test 'should create place' do
    attributes = attributes_for :place
    post :create, place: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_places_path
    place = Place.last
    place.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], place.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @place
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :place
    patch :update, place: attributes, id: @place
    assert_response :redirect, @response.body
    assert_redirected_to admin_places_path
    @place.reload
    @place.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @place.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @place
    @place.reload
    assert @place.removed?
  end
end
