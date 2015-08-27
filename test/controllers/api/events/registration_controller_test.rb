require 'test_helper'

class Api::Events::RegistrationsControllerTest < ActionController::TestCase
  setup do
    member = create :member
    create :event
    member.confirm
    sign_in member
  end

  test 'should get create' do
    attributes = attributes_for :event_registration
    post :create, event_registration: attributes
    assert_response :success
  end

  test 'should delete destroy'  do
    @event_registration = create :event_registration
    count = Event::Registration.count
    delete :destroy, id: 1, event_id: @event_registration.event, user_id: @event_registration.user_id
    assert_response :success, @response.body
    assert_equal count - 1, Event::Registration.count
  end
end
