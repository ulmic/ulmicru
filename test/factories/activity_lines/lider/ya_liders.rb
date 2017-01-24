FactoryGirl.define do
  factory :ya_lider, class: 'ActivityLines::Lider::YaLider' do
    contest_number do
      if ActivityLines::Lider::YaLider.any?
        ActivityLines::Lider::YaLider.order(:contest_number).last.contest_number + 1
      else
        1
      end
    end
    contest_year { generate :integer }
    state { ActivityLines::Lider::YaLider.state_machines[:state].states.map(&:name).first.to_s }
    after :create do
      create :committee, project_type: 'ActivityLines::Lider::YaLider'
      create :token, record_type: 'ActivityLines::Lider::YaLider'
    end
  end
end
