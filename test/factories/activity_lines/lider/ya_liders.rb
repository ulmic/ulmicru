FactoryGirl.define do
  factory :ya_lider, class: 'ActivityLines::Lider::YaLider' do
    contest_number { generate :integer }
    contest_year { generate :integer }
    state { ActivityLines::Lider::YaLider.state_machines[:state].states.map(&:name).first.to_s }
  end
end
