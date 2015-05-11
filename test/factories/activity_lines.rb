FactoryGirl.define do
  factory :activity_line do
    title { generate :string }
    found_date { DateTime.now }
    activity_type :central_program
    description { generate :string }
    member_id { Member.last ? Member.last.id : 1  }
  end
end
