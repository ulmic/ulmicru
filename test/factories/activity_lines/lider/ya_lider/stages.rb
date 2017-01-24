FactoryGirl.define do
  factory :ya_lider_stage, class: 'ActivityLines::Lider::YaLider::Stage' do
    number { generate :integer }
    contest_id do 
      yal = ActivityLines::Lider::YaLider.last
      yal.present? ? yal.id : create(:ya_lider).id
    end
    title { generate :string }
    begin_date { generate :date }
    end_date { generate :date }
    state { ActivityLines::Lider::YaLider::Stage.state_machines[:state].states.map(&:name).first.to_s }
  end
end
