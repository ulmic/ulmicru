require 'test_helper'

class Web::Admin::Events::OnlineConferencesControllerTest < ActionController::TestCase
  setup do
    @online_conference = create :events_online_conference
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'date']
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @online_conference.link
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    ::Events::OnlineConference.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create online_conference' do
    attributes = attributes_for :online_conference
    post :create, online_conference: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_online_conferences_path
    online_conference = ::Events::OnlineConference.last
    online_conference.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], online_conference.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @online_conference
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :online_conference
    patch :update, online_conference: attributes, id: @online_conference
    assert_response :redirect, @response.body
    assert_redirected_to edit_admin_online_conference_path @online_conference
    @online_conference.reload
    @online_conference.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @online_conference.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @online_conference
    @online_conference.reload
    assert @online_conference.removed?
  end
end
