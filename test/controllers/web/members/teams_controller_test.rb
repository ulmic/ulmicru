require 'test_helper'

class Web::Members::TeamsControllerTest < ActionController::TestCase
  setup do
    member = create :member, member_state: :confirmed
    sign_in member
    @team = create :departament, member: member
  end

  test 'should get edit' do
    get :edit, id: @team
    assert_response :success
  end

  test 'should patch update' do
    attributes = { description: generate(:string) }
    patch :update, id: @team, team: attributes
    assert_response :redirect
    assert_redirected_to edit_members_team_path @team
    @team.reload
    attributes.each do |key, value|
      assert_equal @team.send(key), value
    end  
  end
end
