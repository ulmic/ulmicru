require 'test_helper'

class Web::Admin::TrashControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @types = trash_models
    @instances = {}
    @types.each do |type|
      @instances[type] = create type
      @instances[type].remove
    end
  end

  test 'should get index' do
    @types.each do |type|
      get :index, type: type
      assert_response :success, @response.body
    end
  end

  test 'should not get index' do
    get :index, type: :kirpich
    assert_response :redirect, @response.body
    assert_redirected_to not_found_page_path
  end

  test 'should get index without instances' do
    @types.each do |type|
      type.to_s.camelize.constantize.all.map &:destroy
      get :index, type: type
      assert_response :success, @response.body
    end
  end

  test 'should patch restore' do
    @types.each do |type|
      patch :restore, type: type, id: @instances[type].id
      @instances[type].reload
      assert @instances[type].unviewed?
      assert_response :redirect, @response.body
    end
  end

  test 'should delete destroy' do
    @types.each do |type|
      const = type.to_s.camelize.constantize
      count = const.count
      delete :destroy, type: type, id: @instances[type].id
      assert_equal count - 1, const.count
      assert_response :redirect, @response.body
    end
  end
end
