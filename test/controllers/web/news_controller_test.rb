require 'test_helper'

class Web::NewsControllerTest < ActionController::TestCase
  setup do
    @news = create :news
  end

  test "should get index" do
    get :index
    assert_response :success, @response.body
  end

  test "should get show" do
    get :show, id: @news
    assert_response :success, @response.body
  end
end
