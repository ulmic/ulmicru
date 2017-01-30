require 'test_helper'

class Api::ActivityLines::Lider::YaLidersControllerTest < ActionController::TestCase
  setup do
    @ya_lider = create :ya_lider
    create :token, record_type: @ya_lider.class.name
  end

  test 'should get show' do
    get :show, token: Token.last.content
    assert_response :success
    body = JSON.parse response.body
    assert_equal @ya_lider.provision, body['provision']
  end
end
