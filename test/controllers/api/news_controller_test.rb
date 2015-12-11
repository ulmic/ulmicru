require 'test_helper'

class Api::NewsControllerTest < ActionController::TestCase
  setup do
    create :news
  end

  test 'should get index' do
    get :index, count: 5
    assert_response :success, @response.body
  end

  test 'should get index with ids' do
    get :index, count: 5, data: :id
    assert_response :success, @response.body
  end
end
