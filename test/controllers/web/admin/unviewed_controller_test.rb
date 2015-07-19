require 'test_helper'

class Web::Admin::UnviewedControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @member = create :member
    @types = [ :user, :member, :questionary, :news, :article, :event, :feedback, :comment ]
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
end
