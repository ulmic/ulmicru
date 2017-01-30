require 'test_helper'

class Web::Admin::ActivityLines::Lider::YaLider::ParticipantsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :ya_lider
    @participant = create :ya_lider_participant
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'begin_date', 'end_date']
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get index with search' do
    get :index, search: @participant.contest_id
    assert_response :success
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      ActivityLines::Lider::YaLider::ParticipantDecorator.collections.each do |collection|
        pages = ActivityLines::Lider::YaLider::Participant.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
          print "Page #{page} of #{pages} of #{collection}\r"
        end
      end
    end
  end

  test 'should get index with contest_id' do
    get :index, contest_id: @participant.contest_id
    assert_response :success
  end

  test 'should get index with contest_id and search' do
    get :index, contest_id: @participant.contest_id, search: @participant.user.first_name
    assert_response :success
  end

  test 'should get new' do
    get :new, activity_lines_lider_ya_lider_participant: { contest_id: ActivityLines::Lider::YaLider.last.id }
    assert_response :success, @response.body
  end

  test 'should create participant' do
    attributes = attributes_for :ya_lider_participant
    attributes[:arguments_attributes] = {}
    attributes[:arguments_attributes]['0'] = attributes_for :argument
    post :create, activity_lines_lider_ya_lider_participant: attributes
    participant = ActivityLines::Lider::YaLider::Participant.last
    assert_response :redirect, @response.body
    assert_redirected_to admin_activity_lines_lider_ya_lider_stage_path participant.contest.first_stage.id
    participant.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], participant.send(key), key
    end
  end

  test 'should not create participant' do
    attributes = { user_id: @participant.user_id }
    post :create, activity_lines_lider_ya_lider_participant: attributes
    assert_response :success
  end

  test 'should get edit by admin' do
    4.times { create :argument }
    get :edit, id: @participant
    assert_response :success
  end

  test 'should update participant by admin' do
    attributes = attributes_for :ya_lider_participant
    put :update, id: @participant, activity_lines_lider_ya_lider_participant: attributes
    assert_response :redirect
    assert_redirected_to admin_activity_lines_lider_ya_liders_path
    @participant.reload
    @participant.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @participant.send(key), key
    end
  end

  test 'should not update participant by admin' do
    attributes = attributes_for :ya_lider_participant
    attributes[:user_id] = nil
    count_before_save = ActivityLines::Lider::YaLider::Participant.count
    put :update, id: @participant, activity_lines_lider_ya_lider_participant: attributes
    assert_equal ActivityLines::Lider::YaLider::Participant.count, count_before_save
    assert_response :success
  end

  test 'should destroy participant' do
    delete :destroy, id: @participant
    @participant.reload
    assert @participant.removed?
  end
end
