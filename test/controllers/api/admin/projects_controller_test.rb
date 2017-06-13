require 'test_helper'

class Api::Admin::ProjectsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :place
  end

  test 'should get index' do
    get :index
    assert_response :success
  end
end
