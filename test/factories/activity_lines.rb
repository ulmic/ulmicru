FactoryGirl.define do
  factory :activity_line do
    title { generate :string }
    found_date { DateTime.now }
    description { generate :string }
    member_id { create(:member).id }
    activity_type { ActivityLine.activity_type.values.first }
    state { ActivityLine.state_machines[:state].states.map(&:name).first.to_s }
  end
end
