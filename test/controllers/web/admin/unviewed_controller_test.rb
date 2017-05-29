require 'test_helper'

class Web::Admin::UnviewedControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @member = create :member
    @types = [ :member, :questionary, :news, :event, :feedback, :comment, :position, :team ]
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
    end
  end

  test 'should get index without instances' do
    unless ENV['DB'] == 'prod'
      @types.each do |type|
        unless type == :team
          type.to_s.camelize.constantize.delete_all
        end
      end
      get :index
      if @member.role.tech_admin?
        assert_response :success, @response.body
      else
        assert_response :redirect, @response.body
      end
    end
  end
end
