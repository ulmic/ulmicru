require 'test_helper'

class Web::EventsControllerTest < ActionController::TestCase
  setup do
    @member = create :member
    @event = create :event, creator: @member
    sign_in @member
    @time_quantum = 1.seconds
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

  test 'should get show all events with time for unsigned user' do
    if ENV['DB'] == 'prod'
      sign_out
      count = Event.count
      Event.order(id: :desc).find_each.with_index do |event, index|
        time = Time.now
        get :show, id: event.id
        duration = Time.now - time
        assert_response :success, event.id
        assert duration < @time_quantum, "#{duration} secs, Event id #{event.id}"
        print "#{index} of #{count}\r"
      end
    end
  end
end
