require 'test_helper'

class Api::Members::Corporative::ArgumentsControllerTest < ActionController::TestCase
  setup do
    member = create :member, member_state: :confirmed
    sign_in member
  end

  test 'should create argument' do
    count = ::ActivityLines::Corporative::Argument.count
    attributes = { '0' => attributes_for(:argument) }
    post :create, arguments: attributes
    assert_response :success, @response.body
    assert_equal count + 1, ::ActivityLines::Corporative::Argument.count
  end
end
