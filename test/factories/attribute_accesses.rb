FactoryGirl.define do
  factory :attribute_access do
    member_id { Member.last ? Member.last.id : create(:member).id }
    member_attribute { generate :string }
    access 'hidden'
  end
end
