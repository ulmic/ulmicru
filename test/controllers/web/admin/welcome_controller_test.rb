require 'test_helper'

class Web::Admin::WelcomeControllerTest < ActionController::TestCase
  test 'should get index' do
    admin = create :admin
    sign_in admin
    create :member, :with_views
    get :index
    assert_response :success, @response.body
  end
end
