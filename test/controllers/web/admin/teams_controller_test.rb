require 'test_helper'

class Web::Admin::TeamsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    @team = create :team
  end

  test "should get index" do
    get :index
    assert_response :success, @response.body
  end

  test "should get new" do
    get :new
    assert_response :success, @response.body
  end

  test "should create team" do
    attributes = attributes_for :team
    post :create, team: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_teams_path
    assert_equal attributes[:body], Team.last.body
  end

  test "should not create team" do
    attributes = { body: @team.body }
    post :create, team: attributes
    assert_response :success
  end

  test "should get edit by admin" do
    get :edit, id: @team
    assert_response :success
  end

  test "should update team" do
    attributes = attributes_for :team
    put :update, id: @team, team: attributes
    assert_response :redirect
    @team.reload
    assert_equal attributes[:title], @team.title
  end

  test "should not update team" do
    attributes = attributes_for :team
    attributes[:title] = nil
    count_before_save = Team.count
    put :update, id: @team, team: attributes
    assert_equal Team.count, count_before_save
    assert_response :success
  end

  test "should destroy team" do
    count =  Team.count
    delete :destroy, id: @team
    @team.reload
    assert @team.removed?
  end
end
