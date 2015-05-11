FactoryGirl.define do
  factory :team do
    title { generate :string }
    member_id { Member.last ? Member.last.id : 1 }
    description { generate :string }
  end
end
