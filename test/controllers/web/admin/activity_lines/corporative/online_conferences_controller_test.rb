require 'test_helper'

class Web::Admin::ActivityLines::Corporative::OnlineConferencesControllerTest < ActionController::TestCase
  setup do
    @online_conference = create :activity_lines_corporative_online_conference
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
    get :index, search: @online_conference.video_link
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      ActivityLines::Corporative::OnlineConferenceDecorator.collections.each do |collection|
        pages = ActivityLines::Corporative::OnlineConference.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
        end
      end
    end
  end
  test 'should get index without instances' do
    ::ActivityLines::Corporative::OnlineConference.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create online_conference' do
    attributes = attributes_for :activity_lines_corporative_online_conference
    post :create, activity_lines_corporative_online_conference: attributes
    online_conference = ::ActivityLines::Corporative::OnlineConference.last
    event_attributes = { title: online_conference.decorate.event_title,
      begin_date: online_conference.date,
      end_date: online_conference.date + 3.hours,
      creator_id: current_user.id }
    assert_response :redirect, @response.body
    assert_redirected_to new_admin_event_path event: event_attributes
    online_conference = ::ActivityLines::Corporative::OnlineConference.last
    online_conference.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], online_conference.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @online_conference
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :activity_lines_corporative_online_conference
    patch :update, activity_lines_corporative_online_conference: attributes, id: @online_conference
    assert_response :redirect, @response.body
    assert_redirected_to admin_activity_lines_corporative_online_conference_path @online_conference
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
