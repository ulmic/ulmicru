FactoryGirl.define do
  factory :ya_lider_participation, class: 'ActivityLines::Lider::YaLider::Participation' do
    stage_id do
      if ActivityLines::Lider::YaLider::Stage.last
        ActivityLines::Lider::YaLider::Stage.last.id
      else
        create(:ya_lider_stage).id
      end
    end
    user_id { User.last.present? ? User.last.id : create(:user).id }
    state { ActivityLines::Lider::YaLider::Participation.state_machines[:state].states.map(&:name).first.to_s }
  end
end
