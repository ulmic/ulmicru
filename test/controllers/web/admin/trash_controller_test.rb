require 'test_helper'

class Web::Admin::TrashControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    exceptions = [ :article, :category, :online_conference, :document, :tag ]
    @types = trash_models.except(*exceptions)
    @hard_types = {
      'activity_lines/corporative/confession' =>  'activity_lines-corporative-confession',
      'activity_lines/corporative/online_conference' =>  'activity_lines-corporative-online_conference'
    }
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

  test 'should get index with hard types' do
    @hard_types.values.each do |value|
      get :index, type: value
      assert_response :success, @response.body
    end
  end

  test 'should get index without instances with hard types' do
    @hard_types.keys.each do |key|
      key.camelize.constantize.destroy_all
      get :index, type: @hard_types[key]
      assert_response :success, @response.body
    end
  end

  test 'should patch restore' do
    restore_active_model = [:tag]
    @types.each do |type|
      patch :restore, type: type, id: @instances[type].id
      @instances[type].reload
      restored_state = type.in?(restore_active_model) ? :active : :unviewed
      assert @instances[type].send("#{restored_state}?"), "#{@instances[type].send("#{restored_state}?")} #{type} #{restored_state}"
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
