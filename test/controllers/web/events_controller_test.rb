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
    @event.organizer = create :departament
    @event.save
    15.times { create :user; create :event_registration }
    get :show, id: @event
    assert_response :success, @response.body
  end

  test 'should get show all events' do
    if ENV['DB'] == 'prod'
      count = Event.count
      Event.find_each.with_index do |event, index|
        get :show, id: event.id
        assert_response :success, event.id
        print "#{index} of #{count}\r"
      end
    end
  end
end
