require 'test_helper'

class Api::Events::RegistrationsControllerTest < ActionController::TestCase
  setup do
    @event = create :event
  end

  test 'should get create' do
    attributes = attributes_for :event
    post :create, event: attributes
    assert_response :success
  end

  test 'should delete destroy'  do
    delete :destroy, id: @event
    assert_response :success, @response.body
    @event.reload
    assert @event.removed?
  end
end
