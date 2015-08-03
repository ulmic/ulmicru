require 'test_helper'

class Web::Admin::BannersControllerTest < ActionController::TestCase
  setup do
    @banner = create :banner
    admin = create :admin
    sign_in admin
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create banner' do
    attributes = attributes_for :banner
    post :create, banner: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_banners_path
    assert_equal attributes[:link], Banner.last.link
  end

  test 'should get edit' do
    get :edit, id: @banner
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :banner
    patch :update, banner: attributes, id: @banner
    assert_response :redirect, @response.body
    assert_redirected_to edit_admin_banner_path @banner
    @banner.reload
    assert_equal attributes[:link], @banner.link
  end

  test 'should delete destroy' do
    delete :destroy, id: @banner
    @banner.reload
    assert @banner.removed?
  end
end
