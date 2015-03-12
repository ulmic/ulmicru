require 'test_helper'

class Web::Admin::UnviewedControllerTest < ActionController::TestCase
  setup do
    @member = create :member
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end
end
