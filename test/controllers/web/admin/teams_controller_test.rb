require 'test_helper'

class Web::Admin::TeamsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at']
    @team = create :departament
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Team.all.map &:destroy
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create team' do
    attributes = attributes_for :team
    post :create, team: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_teams_path
    team = Team.last
    team.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], team.send(key), key
    end
  end

  test 'should not create team' do
    attributes = { description: @team.description }
    post :create, team: attributes
    assert_response :success
  end

  test 'should get edit by admin' do
    get :edit, id: @team
    assert_response :success
  end

  test 'should update team' do
    attributes = attributes_for :departament
    put :update, id: @team, team: attributes
    assert_response :redirect
    assert_redirected_to edit_admin_team_path @team
    @team.reload
    @team.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @team.send(key), key
    end
  end

  test 'should not update team' do
    attributes = attributes_for :team
    attributes[:title] = nil
    count_before_save = Team.count
    put :update, id: @team, team: attributes
    assert_equal Team.count, count_before_save
    assert_response :success
  end

  test 'should destroy team' do
    count =  Team.count
    delete :destroy, id: @team
    @team.reload
    assert @team.removed?
  end
end
