require 'test_helper'

class Web::Admin::UnviewedControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @member = create :member
    @types = [ :member, :questionary, :news, :article, :event, :feedback, :comment, :position ]
    @instances = {}
    @types.each do |type|
      @instances[type] = create type
      @instances[type].state = :unviewed
      @instances[type].save
    end
  end

  test 'should get index' do
    @types.each do |type|
      get :index
      assert_response :redirect, @response.body
      assert_redirected_to admin_unviewed_index_path items: :member
    end
  end

  test 'should get index without instances' do
    @types.each do |type|
      type.to_s.camelize.constantize.destroy_all
    end
    get :index
    assert_response :success, @response.body
  end
end
