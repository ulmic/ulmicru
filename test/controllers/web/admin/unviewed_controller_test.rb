require 'test_helper'

class Web::Admin::UnviewedControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @member = create :member
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end
end
