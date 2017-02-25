require 'test_helper'

class Xls::ActivityLines::Lider::YaLider::ParticipantsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :ya_lider
    @participant = create :ya_lider_participant
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'begin_date', 'end_date']
  end

#  test 'should get index' do
#    get :index, contest_id: @participant.contest_id
#    assert_response :success
#  end
end
