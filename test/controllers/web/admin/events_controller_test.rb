require 'test_helper'

class Web::Admin::EventsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :member
    @event = create :event
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create event' do
    attributes = attributes_for :event
    post :create, event: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_events_path
    assert_equal attributes[:title], Event.last.title
  end

  test 'should get edit' do
    get :edit, id: @event
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :event
    patch :update, event: attributes, id: @event
    assert_response :redirect, @response.body
    assert_redirected_to admin_events_path
    @event.reload
    assert_equal attributes[:title], @event.title
  end

  test 'should delete destroy' do
    count = Event.count
    delete :destroy, id: @event
    @event.reload
    assert @event.removed?
  end
end
