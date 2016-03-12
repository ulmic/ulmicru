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
      assert_response :success, @response.body
    end
  end

  test 'should get index without instances' do
    @types.each do |type|
      type.to_s.camelize.constantize.destroy_all
      get :index
      assert_response :success, @response.body
    end
  end
end
