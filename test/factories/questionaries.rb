FactoryGirl.define do
  factory :questionary do
    member_id { Member.last ? Member.last.id : 1 }
    experience { generate :string }
    want_to_do { generate :string }
  end
end
