require 'test_helper'

class Web::Admin::ActivityLines::Lider::YaLider::StagesControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @stage = create :ya_lider_stage
    @exceptions_attributes = ['id', 'begin_date', 'end_date', 'created_at', 'updated_at']
  end

  test 'should get new' do
    get :new, activity_lines_lider_ya_lider_stage: { contest_id: ActivityLines::Lider::YaLider.last.id }
    assert_response :success, @response.body
  end

  test 'should create stage' do
    attributes = attributes_for :ya_lider_stage
    attributes[:arguments_attributes] = {}
    attributes[:arguments_attributes]['0'] = attributes_for :argument
    post :create, activity_lines_lider_ya_lider_stage: attributes
    stage = ActivityLines::Lider::YaLider::Stage.last
    assert_response :redirect, @response.body
    assert_redirected_to admin_activity_lines_lider_ya_lider_path(stage.contest)
    stage.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], stage.send(key), key
    end
  end

  test 'should not create stage' do
    attributes = { number: @stage.number, contest_id: @stage.contest_id }
    post :create, activity_lines_lider_ya_lider_stage: attributes
    assert_response :success
  end

  test 'should get edit by admin' do
    4.times { create :argument }
    get :edit, id: @stage
    assert_response :success
  end

  test 'should update stage by admin' do
    attributes = attributes_for :ya_lider_stage
    put :update, id: @stage, activity_lines_lider_ya_lider_stage: attributes
    assert_response :redirect
    assert_redirected_to admin_activity_lines_lider_ya_lider_path @stage.contest
    @stage.reload
    @stage.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @stage.send(key), key
    end
  end

  test 'should not update stage by admin' do
    attributes = attributes_for :ya_lider_stage
    attributes[:number] = nil
    count_before_save = ActivityLines::Lider::YaLider::Stage.count
    put :update, id: @stage, activity_lines_lider_ya_lider_stage: attributes
    assert_equal ActivityLines::Lider::YaLider::Stage.count, count_before_save
    assert_response :success
  end

  test 'should destroy stage' do
    delete :destroy, id: @stage
    @stage.reload
    assert @stage.removed?
  end
end
