require 'test_helper'

class Web::EventsControllerTest < ActionController::TestCase
  setup do
    @member = create :member
    @event = create :event, creator: @member
    sign_in @member
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    @event.organizer = create :team
    @event.save
    15.times { create :user; create :event_registration }
    get :show, id: @event
    assert_response :success, @response.body
  end
end
