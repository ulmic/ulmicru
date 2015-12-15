FactoryGirl.define do
  factory :confession, class: 'ActivityLines::Corporative::Confession' do
    year { DateTime.now.year }
    nomination { ActivityLines::Corporative::Confession.nomination.values.first }
    member_id { Member.last ? Member.last.id : create(:member).id }
    state { ActivityLines::Corporative::Confession.state_machines[:state].states.map(&:name).first.to_s }

    after(:create) do |c|
      FactoryGirl.create_list :argument, 4
    end
  end

  factory :petition, parent: :confession do
    year DateTime.now.year
  end
end
