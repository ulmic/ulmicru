require 'test_helper'

class Api::Events::RegistrationsControllerTest < ActionController::TestCase
  setup do
    user = create :user
    create :event
    user.confirm
    sign_in user
  end

  test 'should get create' do
    attributes = attributes_for :event_registration
    attributes[:user_id] = current_user.id
    post :create, event_registration: attributes
    assert_response :success
  end

  test 'should delete destroy'  do
    @event_registration = create :event_registration
    @event_registration.update user_id: current_user.id
    count = Event::Registration.count
    delete :destroy, id: 1, event_id: @event_registration.event, user_id: @event_registration.user_id
    assert_response :success, @response.body
    assert_equal count - 1, Event::Registration.count
  end
end
