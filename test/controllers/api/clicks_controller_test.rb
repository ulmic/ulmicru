require 'test_helper'

class Api::ClicksControllerTest < ActionController::TestCase
  test 'should post create' do
    attributes = attributes_for :click
    post :create, click: attributes
    assert_response :success
  end
end
