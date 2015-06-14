require 'test_helper'

class Api::Events::RegistrationsControllerTest < ActionController::TestCase
  setup do
    user = create :user
    create :event
    user.confirm
    sign_in user
    @event_registration = create :event_registration
  end

  test 'should get create' do
    attributes = attributes_for :event_registration
    post :create, event_registration: attributes
    assert_response :success
  end

  test 'should delete destroy'  do
    count = Event::Registration.count
    delete :destroy, id: 1, event_id: @event_registration.event, user_id: @event_registration.user
    assert_response :success, @response.body
    assert_equal count - 1, Event::Registration.count
  end
end
