FactoryGirl.define do
  factory :position do
    title { generate :string }
    member_id { Member.last ? Member.last.id : create(:member).id }
    begin_date { DateTime.now }
    end_date { DateTime.now }
    state { Position.state_machines[:state].states.map(&:name).first.to_s }
  end
end
