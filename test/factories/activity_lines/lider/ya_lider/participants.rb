FactoryGirl.define do
  factory :ya_lider_participant, class: 'ActivityLines::Lider::YaLider::Participant' do
    contest_id { create(:ya_lider_with_stages).id }
    user_id { User.last ? User.last.id : create(:user).id }
    state { ActivityLines::Lider::YaLider::Participant.state_machines[:state].states.map(&:name).first.to_s }
  end
end
