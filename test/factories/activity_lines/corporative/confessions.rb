FactoryGirl.define do
  factory :confession, class: 'ActivityLines::Corporative::Confession' do
    year { DateTime.now.year }
    nomination { ActivityLines::Corporative::Confession.nomination.values.first }
    member_id { create(:member).id }
    state { ActivityLines::Corporative::Confession.state_machines[:state].states.map(&:name).first.to_s }
  end

  factory :petition, parent: :confession do
    year 2016
  end
end
