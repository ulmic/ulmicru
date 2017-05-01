require 'test_helper'

class Web::Admin::Delivery::ContactEmailsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
  end

  test 'should get index' do
    get :index
    assert_response :success
  end
end
