require 'test_helper'

class Web::EventsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    @event = create :event, creator: @user
    sign_in @user
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    get :show
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create member' do
    attributes = attributes_for :event
    post :create, event: attributes
    assert_redirected_to root_path
    assert_equal attributes[:title], Event.last.title
  end
end
