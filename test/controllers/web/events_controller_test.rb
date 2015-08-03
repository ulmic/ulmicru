require 'test_helper'

class Web::EventsControllerTest < ActionController::TestCase
  setup do
    @member = create :member
    @event = create :event, creator: @member
    sign_in @member
    stub_request(:get, "https://api.foursquare.com/v2/venues/#{@event.place}?client_id=#{OAUTH_KEYS[:foursquare][:client_id]}&client_secret=#{OAUTH_KEYS[:foursquare][:client_secret]}&v=#{configus.api.foursquare.version}").with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).to_return(status: 200, body: File.new("#{Rails.root}/test/mock/foursquare/place.json"), headers: {})
    create :article, :contacts
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    @event.organizer = create :team
    @event.save
    15.times { create :user; create :event_registration }
    stub_request(:get, "https://api.foursquare.com/v2/venues/#{@event.place}?client_id=#{OAUTH_KEYS[:foursquare][:client_id]}&client_secret=#{OAUTH_KEYS[:foursquare][:client_secret]}&v=#{configus.api.foursquare.version}").with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).to_return(status: 200, body: File.new("#{Rails.root}/test/mock/foursquare/place.json"), headers: {})
    get :show, id: @event
    assert_response :success, @response.body
  end
end
