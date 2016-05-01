require 'test_helper'

class Web::Admin::EventsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :member
    @event = create :event
    stub_request(:get, "https://api.foursquare.com/v2/venues/#{@event.place}?client_id=#{OAUTH_KEYS[:foursquare][:client_id]}&client_secret=#{OAUTH_KEYS[:foursquare][:client_secret]}&v=#{configus.api.foursquare.version}").with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).to_return(status: 200, body: File.new("#{Rails.root}/test/mock/foursquare/place.json"), headers: {})
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'main_photo', 'begin_date', 'end_date']
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @event.title
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Event.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create event' do
    attributes = attributes_for :event
    # FIXME put in factory
    attributes[:registrations_attributes] = {
      '0' => attributes_for(:event_registration)
    }
    post :create, event: attributes
    assert_response :redirect
    assert_redirected_to admin_events_path
    event = Event.last
    event.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], event.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @event
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :event
    patch :update, event: attributes, id: @event
    assert_response :redirect, @response.body
    assert_redirected_to edit_admin_event_path @event
    @event.reload
    @event.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @event.send(key), key
    end
  end

  test 'should delete destroy' do
    count = Event.count
    delete :destroy, id: @event
    @event.reload
    assert @event.removed?
  end
end
