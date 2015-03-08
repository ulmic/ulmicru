FactoryGirl.define do
  factory :attribute_access do
    member_id { Member.last ? Member.last.id : 1 }
    member_attribute { generate :string }
    access 'hidden'
  end
end
