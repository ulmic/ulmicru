require 'test_helper'

class Web::TeamsControllerTest < ActionController::TestCase
  setup do
    @team = create :team
    create :article, :contacts
  end

  test "should get show" do
    get :show, id: @team
    assert_response :success, @response.body
  end
end
